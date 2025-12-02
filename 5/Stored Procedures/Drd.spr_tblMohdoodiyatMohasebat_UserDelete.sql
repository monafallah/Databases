SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMohdoodiyatMohasebat_UserDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
UPDATE     [Drd].[tblMohdoodiyatMohasebat_User]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldMahdoodiyatMohasebatId = @fldId
	DELETE
	FROM   [Drd].[tblMohdoodiyatMohasebat_User]
	WHERE  fldMahdoodiyatMohasebatId = @fldId

	COMMIT
GO
