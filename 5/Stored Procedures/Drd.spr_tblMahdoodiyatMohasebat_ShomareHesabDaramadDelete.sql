SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_ShomareHesabDaramadDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldMahdodiyatMohasebatId = @fldId
	
	DELETE
	FROM   [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]
	WHERE  fldMahdodiyatMohasebatId = @fldId

	COMMIT
GO
