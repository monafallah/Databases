SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabetDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE [Drd].[tblParametreSabet]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblParametreSabet]
	WHERE  fldId = @fldId

	COMMIT
GO
