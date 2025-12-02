SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	DELETE
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas]
	WHERE  fldMahdoodiyatMohasebatId = @fldId
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	end
	IF(@flag=0)
	BEGIN
	DELETE
	FROM   [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]
	WHERE  fldMahdodiyatMohasebatId = @fldId
		IF(@@ERROR<>0)
		BEGIN
		SET @flag=1
		ROLLBACK
		END
	END
	IF(@flag=0)
	BEGIN
	DELETE
	FROM   [Drd].[tblMohdoodiyatMohasebat_User]
	WHERE  fldMahdoodiyatMohasebatId = @fldId
		IF(@@ERROR<>0)
		BEGIN
		SET @flag=1
		ROLLBACK
		END
	END
	IF(@flag=0)
	BEGIN
		UPDATE    [Drd].[tblMahdoodiyatMohasebat]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblMahdoodiyatMohasebat]
	WHERE  fldId = @fldId
		IF(@@ERROR<>0)
		BEGIN
		SET @flag=1
		ROLLBACK
		END
	end
	COMMIT
GO
