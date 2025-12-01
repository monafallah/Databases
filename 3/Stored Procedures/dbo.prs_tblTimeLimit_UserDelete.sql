SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserDelete] 
	@fldUserId int,
	@fldInputId  int
AS 
	BEGIN TRAN
	--insert tblLogTable
	--select 68,@fldUserId,@fldInputId,GETDATE(),3
	--if(@@ERROR<>0)
	--begin
	--rollback
	--end
	--else
	--begin
	DELETE
	FROM   [dbo].[tblTimeLimit_User]
	WHERE  fldUserId= @fldUserId
	if(@@ERROR<>0)
	rollback
	--end
	COMMIT
GO
