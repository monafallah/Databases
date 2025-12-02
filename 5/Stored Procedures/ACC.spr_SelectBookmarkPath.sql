SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectBookmarkPath]
@fldDocumentRecordeId int
as
begin
	--declare @fldDocumentRecordeId int=5
	;with c as (
	select a.fldTitle,a.fldId,a.fldPID from acc.tblDocumentBookMark as b
	inner join Arch.tblArchiveTree as a on a.fldId=b.fldArchiveTreeId
	where b.fldDocumentRecordeId=@fldDocumentRecordeId
	union all
	select a.fldTitle,a.fldId,a.fldPID from Arch.tblArchiveTree as a 
	inner join c on c.fldPID=a.fldId
	)
	select stuff((select '-'+fldTitle from c order by fldid for xml path('')),1,1,'') as fldTitle

end
GO
