SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_Pre_Update]
as
begin
;with a
as
(
	select min(fldId) as fldid,fldCaseTypeId,fldSourceId from ACC.tblCase group by fldCaseTypeId,fldSourceId
)--select * from a order by fldCaseTypeId,fldSourceId
,b
as
(
	select d.fldId,c.fldCaseTypeId,c.fldSourceId from ACC.tblDocumentRecord_Details d inner join ACC.tblCase c on d.fldCaseId=c.fldId 
)
,c
as
(
	select b.fldId,a.fldid newcaseid from b inner join a on a.fldCaseTypeId=b.fldCaseTypeId and a.fldSourceId=b.fldSourceId
)update ACC.tblDocumentRecord_Details  set fldCaseId=c.newcaseid from ACC.tblDocumentRecord_Details d inner join c on d.fldId=c.fldId
delete c from ACC.tblCase c left join ACC.tblDocumentRecord_Details d on c.fldId=d.fldCaseId where d.fldCaseId is null
end
GO
