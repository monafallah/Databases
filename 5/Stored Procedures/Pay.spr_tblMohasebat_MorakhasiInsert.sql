SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_MorakhasiInsert] 

    @fldPersonalId int,
    @fldTedad tinyint,
    @fldMablagh int,
    @fldMonth tinyint,
    @fldYear smallint,
    @fldNobatPardakht tinyint,
    @fldSalHokm smallint,
    @fldHokmId int,
    @fldUserId int,
	@fldorganId INT,
    @fldDesc nvarchar(MAX),
	@fldHesabTypeId tinyint
AS 
	
	BEGIN TRAN
	set @flddesc=com.fn_TextNormalize(@flddEsc) 
	declare @fldID int ,@IdMohasebat INT,@flag BIT=0,@PrsPersonalId INT,@fldShomareHesabId INT,@fldInsurance INT,@ShomareBime NVARCHAR(50)
	,@JobCode NVARCHAR(50),@TypeBime INT,@Sh_hesabPasAndaz NVARCHAR(50)='',@Sh_hesabPasKarFarma NVARCHAR(50)='',@AnvaEstekhdam INT,@EsargariId INT
	,@fldH_BankFixId INT,@fldCostCenterId int,@employeeid INT,@AshkhasId INT,@ChartOrgan int

	SELECT @PrsPersonalId=fldPrs_PersonalInfoId FROM Pay.Pay_tblPersonalInfo WHERE fldId=@fldPersonalId
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_Morakhasi] 
	INSERT INTO [Pay].[tblMohasebat_Morakhasi] ([fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate],fldHesabTypeId)
	SELECT @fldId, @fldPersonalId, @fldTedad, @fldMablagh, @fldMonth, @fldYear, @fldNobatPardakht, @fldSalHokm, @fldHokmId, @fldUserId, @fldDesc, GETDATE(),@fldHesabTypeId
	if(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	--SELECT @fldorganId=fldOrganId FROM Com.tblUser WHERE fldId=@fldUserId
	SELECT @fldH_BankFixId=fldH_BankFixId FROM Pay.tblSetting WHERE fldOrganId=@fldorganId
	--SELECT @fldShomareHesabId=fldId FROM Pay.tblShomareHesabs WHERE fldPersonalId=@fldPersonalId AND fldBankFixedId=@fldH_BankFixId AND fldTypeHesab=0
	SELECT @PrsPersonalId=fldPrs_PersonalInfoId,@fldCostCenterId=fldCostCenterId,@fldInsurance=fldInsuranceWorkShopId 
	,@ShomareBime=fldShomareBime,@JobCode=fldJobeCode,@TypeBime=fldTypeBimeId
	FROM Pay.Pay_tblPersonalInfo WHERE fldid=@fldPersonalId
	SELECT       @EsargariId=Prs.Prs_tblPersonalInfo.fldEsargariId, @ChartOrgan=Com.tblOrganizationalPostsEjraee.fldChartOrganId
FROM            Prs.Prs_tblPersonalInfo left JOIN
                         Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId
						 WHERE Prs.Prs_tblPersonalInfo.fldid=@PrsPersonalId

	SELECT TOP(1) @AnvaEstekhdam=fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=@PrsPersonalId ORDER BY fldTarikh desc
	--SELECT @Sh_hesabPasAndaz=fldShomareHesabPersonal,@Sh_hesabPasKarFarma=fldShomareHesabKarfarma FROM Pay.tblShomareHesabPasAndaz WHERE fldPersonalId=@fldPersonalId
	SELECT    @Sh_hesabPasAndaz=Com.tblShomareHesabeOmoomi.fldShomareHesab,@Sh_hesabPasKarFarma= tblShomareHesabeOmoomi_1.fldShomareHesab 
	FROM         Pay.tblShomareHesabPasAndaz INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS  tblShomareHesabeOmoomi_1 ON Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId
                      WHERE com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@fldPersonalId

	SELECT @employeeid=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@PrsPersonalId
	SELECT @AshkhasId=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@employeeid
	SELECT @fldShomareHesabId=com.tblShomareHesabeOmoomi.fldId FROM com.tblShomareHesabeOmoomi INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId WHERE fldAshkhasId=@AshkhasId AND fldBankId=@fldH_BankFixId AND fldTypeHesab=0
	and fldHesabTypeId=@fldHesabTypeId

	SELECT @IdMohasebat =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_PersonalInfo] 
	INSERT INTO Pay.tblMohasebat_PersonalInfo
	        ( fldId ,fldMohasebatId ,fldVamId ,fldEzafe_TatilKariId , fldMamuriyatId , fldSayerPardakhthaId ,fldCostCenterId ,fldInsuranceWorkShopId ,fldCodeShoghliBime ,fldTypeBimeId ,
	          fldAnvaEstekhdamId ,fldFiscalHeaderId ,fldMoteghayerHoghoghiId ,fldShomareHesabId ,fldShomareBime , fldShPasAndazPersonal ,fldShPasAndazKarFarma ,
	          fldHokmId ,fldTedadBime1 ,fldTedadBime2 ,fldTedadBime3 ,fldT_Asli ,fldT_70 ,fldT_60 ,fldHamsareKarmand ,fldMazad30Sal ,fldMohasebatEydiId ,
	          fldKomakGheyerNaghdiId,fldMorakhasiId , fldStatusIsargariId ,fldOrganId,fldUserId ,fldDesc , fldDate,fldChartOrganId)
	SELECT @IdMohasebat,NULL,NULL,NULL,NULL,NULL,@fldCostCenterId,@fldInsurance,@JobCode,@TypeBime,@AnvaEstekhdam,NULL,NULL,@fldShomareHesabId,@ShomareBime,@Sh_hesabPasAndaz,@Sh_hesabPasKarFarma,
	NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,@fldID,@EsargariId,Com.fn_OrganId(@PrsPersonalId),@fldUserId,@fldDesc,GETDATE(),@ChartOrgan
	IF (@@ERROR<>0)
		ROLLBACK

	end

	COMMIT
GO
