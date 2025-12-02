SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Cntr].[spr_UpdateStatusFactor](@fieldname nvarchar(50),@factorId int,@status bit,@UserId int,@fldDocumentHeaderId1 int)
as
begin tran
if (@fieldname='Factor')
begin
update cntr.tblFactor
set fldStatus=@status ,fldUserId=@UserId,flddate=getdate(),fldDocumentHeaderId1=@fldDocumentHeaderId1
where fldid=@factorId
if (@@ERROR<>0)
	rollback

end
if (@fieldname='Tankhah_Group')
begin
update f 
set fldStatus=@status,fldUserId=@UserId,flddate=getdate(),fldDocumentHeaderId1=@fldDocumentHeaderId1
 from cntr.tblTankhah_Group g
	inner join cntr.tblFactorMostaghel ff on ff.fldTankhahGroupId=g.fldid
	inner join cntr.tblFactor f on f.fldid=ff.fldFactorId
	where g.fldid =@factorId
	if (@@ERROR<>0)
	rollback
end
commit
GO
