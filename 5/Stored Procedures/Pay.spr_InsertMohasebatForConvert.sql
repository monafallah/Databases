SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC  [Pay].[spr_InsertMohasebatForConvert]	
	@fldId INT OUT ,
	@fldPersonalId	int	,
	@fldYear	smallint	,
	@fldMonth	tinyint	,
	@fldKarkard	tinyint	,
	@fldGheybat	tinyint	,
	@fldTedadEzafeKar	DECIMAL(6,3)	,
	@fldTedadTatilKar	DECIMAL(6,3)	,
	@fldBaBeytute	tinyint	,
	@fldBedunBeytute	tinyint	,
	@fldBimeOmrKarFarma	int	,
	@fldBimeOmr	int	,
	@fldBimeTakmilyKarFarma	int	,
	@fldBimeTakmily	int	,
	@fldHaghDarmanKarfFarma	int	,
	@fldHaghDarmanDolat	int	,
	@fldHaghDarman	int	,
	@fldBimePersonal	int	,
	@fldBimeKarFarma	int	,
	@fldBimeBikari	int	,
	@fldBimeMashaghel	int	,
	@fldDarsadBimePersonal	decimal(8, 4)	,
	@fldDarsadBimeKarFarma	decimal(8, 4)	,
	@fldDarsadBimeBikari	decimal(8, 4)	,
	@fldDarsadBimeSakht	decimal(8, 4)	,
	@fldTedadNobatKari	tinyint	,
	@fldMosaede	int	,
	@fldNobatPardakht	int	,
	@fldGhestVam	int	,
	@fldPasAndaz	int	,
	@fldMashmolBime	int	,
	@fldMashmolMaliyat	int	,
	@fldFlag	bit	,
	@fldMogharari	int	,
	@fldMaliyat	int	,
	@fldVamId	int	,
	@fldEzafe_TatilKariId	int	,
	@fldMamuriyatId	int	,
	@fldSayerPardakhthaId	int	,
	@fldCostCenterId	int	,
	@fldInsuranceWorkShopId	int	,
	@fldCodeShoghliBime	nvarchar(50)	,
	@fldTypeBimeId	int	,
	@fldAnvaEstekhdamId	int	,
	@fldFiscalHeaderId	int	,
	@fldMoteghayerHoghoghiId	int	,
	@fldShomareHesabId	int	,
	@fldShomareBime	nvarchar(50)	,
	@fldShPasAndazPersonal	nvarchar(50)	,
	@fldShPasAndazKarFarma	nvarchar(50)	,
	@fldHokmId	int	,
	@fldTedadBime1	int	,
	@fldTedadBime2	int	,
	@fldTedadBime3	int	,
	@fldT_Asli	tinyint	,
	@fldT_70	tinyint	,
	@fldT_60	tinyint	,
	@fldHamsareKarmand	bit	,
	@fldMazad30Sal	bit	,
	@fldMohasebatEydiId	int	,
	@fldKomakGheyerNaghdiId	int	,
	@fldStatusIsargariId	int	,
	@fldMorakhasiId	int	,
	@fldOrganId	int	,
	@fldUserId	int	,
	@fldDesc	nvarchar(MAX)	,
	@fldChartOrganId int,
    @fldShift INT

AS
BEGIN
	DECLARE @flag BIT=0,@Mohasebat_PersonalInfo INT
	SELECT @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat] 
	INSERT INTO [Pay].[tblMohasebat] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag],  [fldMogharari], [fldMaliyat],   [fldUserId], [fldDesc], [fldDate],fldShift)
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldKarkard, @fldGheybat, @fldTedadEzafeKar, @fldTedadTatilKar, @fldBaBeytute, @fldBedunBeytute, @fldBimeOmrKarFarma, @fldBimeOmr, @fldBimeTakmilyKarFarma, @fldBimeTakmily, @fldHaghDarmanKarfFarma, @fldHaghDarmanDolat, @fldHaghDarman, @fldBimePersonal, @fldBimeKarFarma, @fldBimeBikari, @fldBimeMashaghel, @fldDarsadBimePersonal, @fldDarsadBimeKarFarma, @fldDarsadBimeBikari, @fldDarsadBimeSakht, @fldTedadNobatKari, @fldMosaede, @fldNobatPardakht, @fldGhestVam, @fldPasAndaz, @fldMashmolBime, @fldMashmolMaliyat, @fldFlag,  @fldMogharari, @fldMaliyat,  @fldUserId, @fldDesc, GETDATE(),@fldShift
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	select @Mohasebat_PersonalInfo =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_PersonalInfo] 
	INSERT INTO [Pay].[tblMohasebat_PersonalInfo] ([fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId], [fldUserId], [fldDesc], [fldDate],fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldOrganId,fldChartOrganId)
	SELECT @Mohasebat_PersonalInfo, @fldId, @fldVamId, @fldEzafe_TatilKariId, @fldMamuriyatId, @fldSayerPardakhthaId, @fldCostCenterId, @fldInsuranceWorkShopId, @fldCodeShoghliBime, @fldTypeBimeId, @fldAnvaEstekhdamId, @fldFiscalHeaderId, @fldMoteghayerHoghoghiId, @fldShomareHesabId, @fldShomareBime, @fldShPasAndazPersonal, @fldShPasAndazKarFarma, @fldHokmId, @fldTedadBime1, @fldTedadBime2, @fldTedadBime3, @fldT_Asli, @fldT_70, @fldT_60, @fldHamsareKarmand, @fldMazad30Sal, @fldStatusIsargariId, @fldUserId, @fldDesc, GETDATE(),@fldMohasebatEydiId,@fldKomakGheyerNaghdiId,@fldMorakhasiId,@fldOrganId,@fldChartOrganId

	IF(@@ERROR<>0)
		BEGIN
			SET @flag=1
			ROLLBACK
		END

END
end

GO
