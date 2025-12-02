SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateCodingDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE ACC.tblTemplateCoding
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId
	DELETE
	FROM   [ACC].[tblTemplateCoding]
	WHERE  fldId = @fldId

	COMMIT
GO
