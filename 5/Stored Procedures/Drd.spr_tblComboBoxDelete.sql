SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblComboBoxDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Drd].[tblComboBox]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblComboBox]
	WHERE  fldId = @fldId

	COMMIT
GO
