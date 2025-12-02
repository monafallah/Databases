SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_AshkhasDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblMahdoodiyatMohasebat_Ashkhas]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldMahdoodiyatMohasebatId = @fldId
	DELETE
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas]
	WHERE  fldMahdoodiyatMohasebatId = @fldId

	COMMIT
GO
