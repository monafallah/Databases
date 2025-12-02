SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRequestTaghsit_TakhfifDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE   [Drd].[tblRequestTaghsit_Takhfif]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblRequestTaghsit_Takhfif]
	WHERE  fldId = @fldId

	COMMIT
GO
