SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNaghdi_TalabDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE     [Drd].[tblNaghdi_Talab]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	
	DELETE
	FROM   [Drd].[tblNaghdi_Talab]
	WHERE  fldId = @fldId

	COMMIT
GO
