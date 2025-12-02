SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateNameDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblTemplateName
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId 
	
	DELETE
	FROM   [ACC].[tblTemplateName]
	WHERE  fldId = @fldId

	COMMIT
GO
