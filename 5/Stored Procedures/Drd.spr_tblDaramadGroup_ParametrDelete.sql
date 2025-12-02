SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE   [Drd].[tblDaramadGroup_Parametr]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblDaramadGroup_Parametr]
	WHERE  fldId = @fldId

	COMMIT
GO
