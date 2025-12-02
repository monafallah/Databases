SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSayerPardakhtsUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldAmount int,
    @fldTitle nvarchar(MAX),
    @fldNobatePardakt tinyint,
    @fldMarhalePardakht tinyint,
    @fldHasMaliyat bit,
    @fldMaliyat int,
    @fldKhalesPardakhti INT,
    @fldShomareHesabId INT,
    @fldCostCenterId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldMostamar tinyint
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	UPDATE [Pay].[tblSayerPardakhts]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldAmount] = @fldAmount, [fldTitle] = @fldTitle, [fldNobatePardakt] = @fldNobatePardakt, [fldMarhalePardakht] = @fldMarhalePardakht, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldHasMaliyat=@fldHasMaliyat,fldMaliyat=@fldMaliyat,fldKhalesPardakhti=@fldKhalesPardakhti,fldMostamar=@fldMostamar
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
			ROLLBACK
			SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE Pay.tblMohasebat_PersonalInfo
	SET /*fldCostCenterId=@fldCostCenterId ,*/fldShomareHesabId=@fldShomareHesabId ,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldSayerPardakhthaId=@fldId
	end
	
	COMMIT TRAN
GO
