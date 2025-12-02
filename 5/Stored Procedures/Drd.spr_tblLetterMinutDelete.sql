SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterMinutDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE    [Drd].[tblLetterMinut]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblLetterMinut]
	WHERE  fldId = @fldId

	COMMIT
GO
