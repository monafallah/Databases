SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_PersonalInfoUpdate] 
    @fldId int,
    @fldMohasebatId int,
    @fldVamId int,
    @fldEzafe_TatilKariId int,
    @fldMamuriyatId int,
    @fldSayerPardakhthaId int,
    @fldCostCenterId int,
    @fldInsuranceWorkShopId int,
    @fldCodeShoghliBime NVARCHAR(50),
    @fldTypeBimeId int,
    @fldAnvaEstekhdamId int,
    @fldFiscalHeaderId int,
    @fldMoteghayerHoghoghiId int,
    @fldShomareHesabId int,
    @fldShomareBime nvarchar(50),
    @fldShPasAndazPersonal nvarchar(50),
    @fldShPasAndazKarFarma nvarchar(50),
    @fldHokmId int,
    @fldTedadBime1 int,
    @fldTedadBime2 int,
    @fldTedadBime3 int,
    @fldT_Asli tinyint,
    @fldT_70 tinyint,
    @fldT_60 tinyint,
    @fldHamsareKarmand bit,
    @fldMazad30Sal bit,
    @fldStatusIsargariId int,
    @fldMohasebatEydiId	int	,
	@fldKomakGheyerNaghdiId	int	,
	@fldMorakhasiId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldShPasAndazPersonal=Com.fn_TextNormalize(@fldShPasAndazPersonal)
	SET @fldShomareBime=Com.fn_TextNormalize(@fldShomareBime)
	SET @fldShPasAndazPersonal=Com.fn_TextNormalize(@fldShPasAndazPersonal)
	SET @fldShPasAndazKarFarma=Com.fn_TextNormalize(@fldShPasAndazKarFarma)
	UPDATE [Pay].[tblMohasebat_PersonalInfo]
	SET    [fldId] = @fldId, [fldMohasebatId] = @fldMohasebatId, [fldVamId] = @fldVamId, [fldEzafe_TatilKariId] = @fldEzafe_TatilKariId, [fldMamuriyatId] = @fldMamuriyatId, [fldSayerPardakhthaId] = @fldSayerPardakhthaId, [fldCostCenterId] = @fldCostCenterId, [fldInsuranceWorkShopId] = @fldInsuranceWorkShopId, [fldCodeShoghliBime] = @fldCodeShoghliBime, [fldTypeBimeId] = @fldTypeBimeId, [fldAnvaEstekhdamId] = @fldAnvaEstekhdamId, [fldFiscalHeaderId] = @fldFiscalHeaderId, [fldMoteghayerHoghoghiId] = @fldMoteghayerHoghoghiId, [fldShomareHesabId] = @fldShomareHesabId, [fldShomareBime] = @fldShomareBime, [fldShPasAndazPersonal] = @fldShPasAndazPersonal, [fldShPasAndazKarFarma] = @fldShPasAndazKarFarma, [fldHokmId] = @fldHokmId, [fldTedadBime1] = @fldTedadBime1, [fldTedadBime2] = @fldTedadBime2, [fldTedadBime3] = @fldTedadBime3, [fldT_Asli] = @fldT_Asli, [fldT_70] = @fldT_70, [fldT_60] = @fldT_60, [fldHamsareKarmand] = @fldHamsareKarmand, [fldMazad30Sal] = @fldMazad30Sal, [fldStatusIsargariId] = @fldStatusIsargariId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldMohasebatEydiId	=@fldMohasebatEydiId,fldKomakGheyerNaghdiId=@fldKomakGheyerNaghdiId,fldMorakhasiId=@fldMorakhasiId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
