SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblProgramSettingDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	
	UPDATE Auto.tblProgramSetting
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	
	
	
	DELETE
	FROM   Auto.tblProgramSetting
	WHERE  fldId = @fldId

	COMMIT

GO
