SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_NerkhDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Drd].[tblParametreSabet_Nerkh]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblParametreSabet_Nerkh]
	WHERE  fldId = @fldId

	COMMIT
GO
