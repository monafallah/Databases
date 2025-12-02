SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatInsert] 
	@fldId int out,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldKarkard tinyint,
    @fldGheybat tinyint,
    @fldTedadEzafeKar DECIMAL(6,3),
    @fldTedadTatilKar DECIMAL(6,3),
    @fldBaBeytute tinyint,
    @fldBedunBeytute tinyint,
    @fldBimeOmrKarFarma int,
    @fldBimeOmr int,
    @fldBimeTakmilyKarFarma int,
    @fldBimeTakmily int,
    @fldHaghDarmanKarfFarma int,
    @fldHaghDarmanDolat int,
    @fldHaghDarman int,
    @fldBimePersonal int,
    @fldBimeKarFarma int,
    @fldBimeBikari int,
    @fldBimeMashaghel int,
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadBimeKarFarma decimal(8, 4),
    @fldDarsadBimeBikari decimal(8, 4),
    @fldDarsadBimeSakht decimal(8, 4),
    @fldTedadNobatKari tinyint,
    @fldMosaede int,
    @fldNobatPardakht int,
    @fldGhestVam int,
    @fldPasAndaz int,
    @fldMashmolBime int,
	@fldMashmolBimeNaKhales int,
    @fldMashmolMaliyat int,
    @fldFlag bit,
    @fldMogharari int,
    @fldMaliyat int,
    @fldFiscalHeaderId INT,
    @fldMoteghayerHoghoghiId INT,
    @fldHokmId INT,
    @fldT_Asli TINYINT,
    @fldT_70 TINYINT,
    @fldT_60 TINYINT,
    @fldHamsareKarmand bit,
    @fldMazad30Sal bit,
    @fldTedadBime1 int,
    @fldTedadBime2 int,
    @fldTedadBime3 INT,
    @fldVamId INT,
    @fldUserId int,
	@fldorganId INT,
    @fldDesc nvarchar(MAX),
    @fldShift int,
	@fldHesabTypeId tinyint,
	@fldMaliyatType tinyint,
	@fldMeetingCount smallint,
	@fldCalcType tinyint=1,
	@fldT_BedonePoshesh tinyint,
	@fldEstelagi tinyint
AS 
	
	BEGIN TRAN
	--@fldMaliyatType=1 محاسبات براساس مالیات سامانه
	--@fldMaliyatType=2 محاسبات براساس مالیات دارایی
	--fldCalcType=1  محاسبات اصلی
	--fldCalcType=2  محاسبات فرعی 


	if(@fldCalcType=2)
	begin
		
		select @fldMaliyat=case when fldMaliyatType=2 then fldMaliyat else @fldMaliyat end 
		from pay.tblMohasebat where fldPersonalId=@fldPersonalId and fldYear=@fldYear and fldMonth=@fldMonth
	end


	declare @IdMohasebat INT,@flag BIT=0,@PrsPersonalId INT,@fldShomareHesabId INT,@fldInsurance INT,@ShomareBime NVARCHAR(50)
	,@JobCode NVARCHAR(50),@TypeBime INT,@Sh_hesabPasAndaz NVARCHAR(50)='',@Sh_hesabPasKarFarma NVARCHAR(50)='',@AnvaEstekhdam INT,@EsargariId INT
	,@fldH_BankFixId INT,@fldP_BankFixId INT,@fldCostCenterId INT,@employeeid INT,@AshkhasId INT,@MaliyatManfi INT,@PMaliyat INT,@ChartOrgan INT


	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat] 
	INSERT INTO [Pay].[tblMohasebat] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag],  [fldMogharari], [fldMaliyat],   [fldUserId], [fldDesc], [fldDate],fldShift,fldHesabTypeId,fldMashmolBimeNaKhales,fldMaliyatType,fldMeetingCount,fldCalcType,fldMaliyatCalc,fldEstelagi)
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldKarkard, @fldGheybat, @fldTedadEzafeKar, @fldTedadTatilKar, @fldBaBeytute, @fldBedunBeytute, @fldBimeOmrKarFarma, @fldBimeOmr, @fldBimeTakmilyKarFarma, @fldBimeTakmily, @fldHaghDarmanKarfFarma, @fldHaghDarmanDolat, @fldHaghDarman, @fldBimePersonal, @fldBimeKarFarma, @fldBimeBikari, @fldBimeMashaghel, @fldDarsadBimePersonal, @fldDarsadBimeKarFarma, @fldDarsadBimeBikari, @fldDarsadBimeSakht, @fldTedadNobatKari, @fldMosaede, @fldNobatPardakht, @fldGhestVam, @fldPasAndaz, @fldMashmolBime, @fldMashmolMaliyat, @fldFlag,  @fldMogharari, @fldMaliyat,  @fldUserId, @fldDesc, GETDATE(),@fldShift,@fldHesabTypeId,@fldMashmolBimeNaKhales,@fldMaliyatType,@fldMeetingCount,@fldCalcType,null,@fldEstelagi
	if(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	--SELECT @fldorganId=fldOrganId FROM Com.tblUser WHERE fldId=@fldUserId
	SELECT @fldH_BankFixId=fldH_BankFixId,@fldP_BankFixId=fldP_BankFixId FROM Pay.tblSetting WHERE fldOrganId=@fldorganId
	--SELECT @fldShomareHesabId=fldId FROM Pay.tblShomareHesabs WHERE fldPersonalId=@fldPersonalId AND fldBankFixedId=@fldH_BankFixId AND fldTypeHesab=1
	SELECT @PrsPersonalId=fldPrs_PersonalInfoId,@fldCostCenterId=fldCostCenterId,@fldInsurance=fldInsuranceWorkShopId 
	,@ShomareBime=fldShomareBime,@JobCode=fldJobeCode,@TypeBime=fldTypeBimeId
	FROM Pay.Pay_tblPersonalInfo WHERE fldid=@fldPersonalId
	SELECT        @ChartOrgan=Com.tblOrganizationalPostsEjraee.fldChartOrganId
	FROM            Prs.Prs_tblPersonalInfo INNER JOIN
                         Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId
						 WHERE Prs.Prs_tblPersonalInfo.fldid=@PrsPersonalId

	SELECT       @EsargariId=Prs.Prs_tblPersonalInfo.fldEsargariId
	FROM            Prs.Prs_tblPersonalInfo 
						 WHERE Prs.Prs_tblPersonalInfo.fldid=@PrsPersonalId

	SELECT TOP(1) @AnvaEstekhdam=fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam 
	WHERE fldPrsPersonalInfoId=@PrsPersonalId 
	and fldTarikh<= Cast(@fldYear as varchar(5))+ '/'+  right('0' + convert(varchar,@fldMonth),2)+'/31'
	ORDER BY fldTarikh desc,fldDate desc
	--SELECT @Sh_hesabPasAndaz=fldShomareHesabPersonal,@Sh_hesabPasKarFarma=fldShomareHesabKarfarma FROM Pay.tblShomareHesabPasAndaz WHERE fldPersonalId=@fldPersonalId
		
		SELECT    @Sh_hesabPasAndaz=Com.tblShomareHesabeOmoomi.fldShomareHesab,@Sh_hesabPasKarFarma= tblShomareHesabeOmoomi_1.fldShomareHesab 
FROM         Pay.tblShomareHesabPasAndaz INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS  tblShomareHesabeOmoomi_1 ON Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId
                      WHERE com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@fldPersonalId
					  and tblShomareHesabeOmoomi.fldBankId=@fldP_BankFixId and tblShomareHesabeOmoomi_1.fldBankId=@fldP_BankFixId

	SELECT @employeeid=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@PrsPersonalId
	SELECT @AshkhasId=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@employeeid
	SELECT @fldShomareHesabId=com.tblShomareHesabeOmoomi.fldId FROM com.tblShomareHesabeOmoomi INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId WHERE fldAshkhasId=@AshkhasId AND fldBankId=@fldH_BankFixId 
	AND fldTypeHesab=0 and fldHesabTypeId=@fldHesabTypeId

	SELECT @IdMohasebat =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_PersonalInfo] 
	INSERT INTO Pay.tblMohasebat_PersonalInfo
	        ( fldId ,fldMohasebatId ,fldVamId ,fldEzafe_TatilKariId , fldMamuriyatId , fldSayerPardakhthaId ,fldCostCenterId ,fldInsuranceWorkShopId ,fldCodeShoghliBime ,fldTypeBimeId ,
	          fldAnvaEstekhdamId ,fldFiscalHeaderId ,fldMoteghayerHoghoghiId ,fldShomareHesabId ,fldShomareBime , fldShPasAndazPersonal ,fldShPasAndazKarFarma ,
	          fldHokmId ,fldTedadBime1 ,fldTedadBime2 ,fldTedadBime3 ,fldT_Asli ,fldT_70 ,fldT_60 ,fldHamsareKarmand ,fldMazad30Sal ,fldMohasebatEydiId ,
	          fldKomakGheyerNaghdiId,fldMorakhasiId , fldStatusIsargariId ,fldOrganId,fldUserId ,fldDesc , fldDate,fldChartOrganId,fldT_BedonePoshesh)
	SELECT @IdMohasebat,@fldID,@fldVamId,NULL,NULL,NULL,@fldCostCenterId,@fldInsurance,@JobCode,@TypeBime,@AnvaEstekhdam,@fldFiscalHeaderId,@fldMoteghayerHoghoghiId
	,@fldShomareHesabId,@ShomareBime,@Sh_hesabPasAndaz,@Sh_hesabPasKarFarma,
	@fldHokmId,@fldTedadBime1,@fldTedadBime2,@fldTedadBime3,@fldT_Asli,@fldT_70,@fldT_60,@fldHamsareKarmand,@fldMazad30Sal,NULL,NULL,NULL,@EsargariId,Com.fn_OrganId(@PrsPersonalId),@fldUserId,@fldDesc,GETDATE(),@ChartOrgan,@fldT_BedonePoshesh
	IF (@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	end
	END


	COMMIT
GO
