SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [ACC].[spr_UpdateExitGhateeiDocument](@idheader int,@fldUserId int)
--declare @idheader int,@fldUserId int
as 
begin tran


delete from acc.tblDocument_HeaderLog
where fldHeaderId=@idheader

if (@@Error<>0)
rollback

else
begin
	update acc.tblDocumentRecord_Header1
	set fldAccept=0,fldUserId=@fldUserId,fldDate=getdate()
	where fldid=@idheader
	if (@@Error<>0)
	rollback
end

commit
GO
