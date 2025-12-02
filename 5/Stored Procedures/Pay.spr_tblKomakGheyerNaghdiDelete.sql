SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKomakGheyerNaghdiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE Pay.tblMohasebat_PersonalInfo
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE   fldKomakGheyerNaghdiId=@fldID
	
	DELETE FROM Pay.tblMohasebat_PersonalInfo
	WHERE fldKomakGheyerNaghdiId=@fldID
	
	UPDATE [Pay].[tblKomakGheyerNaghdi]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	
	DELETE
	FROM   [Pay].[tblKomakGheyerNaghdi]
	WHERE  fldId = @fldId

	COMMIT
GO
