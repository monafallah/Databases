SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_PersonalInfoSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId ,[fldUserId], [fldDesc], [fldDate] ,
	fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldSayerPardakhthaId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldSayerPardakhthaId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldVamId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldVamId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckVamId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldVamId = @Value
	
	if (@fieldname=N'fldEzafe_TatilKariId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldEzafe_TatilKariId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckEzafe_TatilKariId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldEzafe_TatilKariId = @Value
	
	if (@fieldname=N'CheckMamuriyatId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMamuriyatId = @Value
	
	if (@fieldname=N'fldMamuriyatId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMamuriyatId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldCostCenterId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldCostCenterId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckCostCenterId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldCostCenterId = @Value
	
	if (@fieldname=N'fldInsuranceWorkShopId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldInsuranceWorkShopId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckInsuranceWorkShopId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldInsuranceWorkShopId = @Value
	
	if (@fieldname=N'fldTypeBimeId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId], fldOrganId ,[fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldTypeBimeId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldAnvaEstekhdamId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldAnvaEstekhdamId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckAnvaEstekhdamId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldAnvaEstekhdamId = @Value
	
	if (@fieldname=N'fldFiscalHeaderId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldFiscalHeaderId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckFiscalHeaderId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldFiscalHeaderId = @Value
	
	if (@fieldname=N'CheckHokmId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldHokmId = @Value
	
	if (@fieldname=N'fldMoteghayerHoghoghiId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMoteghayerHoghoghiId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckMoteghayerHoghoghiId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMoteghayerHoghoghiId = @Value
	
	if (@fieldname=N'fldHokmId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldHokmId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldShomareHesabId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldShomareHesabId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'CheckShomareHesabId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldShomareHesabId = @Value
	
	if (@fieldname=N'fldStatusIsargariId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldStatusIsargariId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)

if (@fieldname=N'CheckStatusIsargariId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldStatusIsargariId = @Value
	
	
if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMohasebatId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	
	if (@fieldname=N'fldMohasebatEydiId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMohasebatEydiId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
		
		if (@fieldname=N'fldMorakhasiId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldMorakhasiId = @Value AND fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)
	


	if (@fieldname=N'checkShomareHesabId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId,fldT_BedonePoshesh
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldShomareHesabId = @Value




	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldVamId], [fldEzafe_TatilKariId], [fldMamuriyatId], [fldSayerPardakhthaId], [fldCostCenterId], [fldInsuranceWorkShopId], [fldCodeShoghliBime], [fldTypeBimeId], [fldAnvaEstekhdamId], [fldFiscalHeaderId], [fldMoteghayerHoghoghiId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId],fldOrganId , [fldUserId], [fldDesc], [fldDate] 
	,fldMohasebatEydiId,fldKomakGheyerNaghdiId,fldMorakhasiId
	FROM   [Pay].[tblMohasebat_PersonalInfo] 
	WHERE  fldOrganId IN (SELECT fldOrganId FROM Com.tblUser WHERE fldId=@UserId)

	COMMIT
GO
