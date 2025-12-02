SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_PersonalInfoInsert] 

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
    @fldDesc nvarchar(MAX),
	@fldChartOrganId INT,
    @fldT_BedonePoshesh tinyint
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldShPasAndazPersonal=Com.fn_TextNormalize(@fldShPasAndazPersonal)
	SET @fldShomareBime=Com.fn_TextNormalize(@fldShomareBime)
	SET @fldShPasAndazPersonal=Com.fn_TextNormalize(@fldShPasAndazPersonal)
	SET @fldShPasAndazKarFarma=Com.fn_TextNormalize(@fldShPasAndazKarFarma)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_PersonalInfo] 
	INSERT INTO [Pay].[tblMohasebat_PersonalInfo] ([fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId], [fldUserId], [fldDesc], [fldDate],fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldChartOrganId,fldT_BedonePoshesh)
	SELECT @fldId, @fldMohasebatId, @fldVamId, @fldEzafe_TatilKariId, @fldMamuriyatId, @fldSayerPardakhthaId, @fldCostCenterId, @fldInsuranceWorkShopId, @fldCodeShoghliBime, @fldTypeBimeId, @fldAnvaEstekhdamId, @fldFiscalHeaderId, @fldMoteghayerHoghoghiId, @fldShomareHesabId, @fldShomareBime, @fldShPasAndazPersonal, @fldShPasAndazKarFarma, @fldHokmId, @fldTedadBime1, @fldTedadBime2, @fldTedadBime3, @fldT_Asli, @fldT_70, @fldT_60, @fldHamsareKarmand, @fldMazad30Sal, @fldStatusIsargariId, @fldUserId, @fldDesc, GETDATE(),@fldMohasebatEydiId,@fldKomakGheyerNaghdiId,@fldMorakhasiId,@fldChartOrganId,@fldT_BedonePoshesh
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
