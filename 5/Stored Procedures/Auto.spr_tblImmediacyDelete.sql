SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblImmediacyDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	declare @fldFileId int,@flag bit=0
	select @fldFileId=fldFileId from  [Auto].[tblImmediacy]
	where fldid =@fldID

	UPDATE Auto.tblImmediacy
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	if (@@error<>0)
	begin
		rollback 
		set @flag=1
	end
	
	if (@flag=0)
	begin
	
	DELETE
	FROM   [Auto].[tblImmediacy]
	WHERE  fldid= @fldId
		if (@@ERROR<>0)
		begin
			rollback 
			set @flag=1
		end
	end
	if (@flag=0)
	begin
	DELETE 
	FROM Com.tblFile
	WHERE fldId=@fldFileId

	if (@@ERROR<>0)
	ROLLBACK 
	end
	COMMIT
GO
