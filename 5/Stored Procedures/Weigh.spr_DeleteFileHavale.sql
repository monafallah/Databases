SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Weigh].[spr_DeleteFileHavale](@fldid int,@fldUserId int)
as
begin tran
declare @fileId int
select @fileId=fldfileId from Weigh.tblRemittance_Header h 
where fldid=@fldid

update Weigh.tblRemittance_Header
set fldfileId=NULL,fldUserId=@fldUserId
where  fldid=@fldid
if (@@ERROR<>0)
	rollback
else
begin
	delete from com.tblFile
	where fldid=@fileId
	if (@@Error<>0)
		rollback

end

commit
GO
