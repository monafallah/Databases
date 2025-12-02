SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblCommisionDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	declare @Flag bit=0

	UPDATE Auto.tblCommision
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	if (@@error<>0)
	begin
		rollback
		set  @flag=1
	end
	if (@flag=0)
	begin
	delete from Auto.tblbox
	where fldComisionID=@fldid
		if (@@error<>0)
		begin
			rollback
			set  @flag=1
		end
	end
	if (@flag=0)
	begin
	DELETE
	FROM   [Auto].[tblCommision]
	WHERE  fldId = @fldId
		if (@@error<>0)
		begin
			rollback
			set  @flag=1
		end
	end
	COMMIT
GO
