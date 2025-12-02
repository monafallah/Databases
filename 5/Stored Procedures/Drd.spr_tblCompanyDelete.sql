SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCompanyDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblCompany]
	SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	
	DELETE
	FROM   [Drd].[tblCompany]
	WHERE  fldId = @fldId

	COMMIT
GO
