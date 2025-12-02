SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSayerPardakhtsDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE Pay.tblMohasebat_PersonalInfo
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE   fldSayerPardakhthaId=@fldID
	
	DELETE FROM Pay.tblMohasebat_PersonalInfo
	WHERE fldSayerPardakhthaId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE [Pay].[tblSayerPardakhts]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE    fldId = @fldId
	DELETE
	FROM   [Pay].[tblSayerPardakhts]
	WHERE  fldId = @fldId
	end
	
	
	COMMIT
GO
