SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterSignersDelete] 
	@fldLetterMinutId int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblLetterSigners]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldLetterMinutId = @fldLetterMinutId
	DELETE
	FROM   [Drd].[tblLetterSigners]
	WHERE  fldLetterMinutId = @fldLetterMinutId

	COMMIT
GO
