SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKomakGheyerNaghdiInsert] 

    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNoeMostamer bit,
    @fldMablagh int,
    @fldKhalesPardakhti int,
    @fldMaliyat int,
    @fldShomareHesabId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@IdMohasebat INT,@flag BIT=0,@PrsPersonalId INT,@fldCostCenterId INT,@fldInsurance INT,@ShomareBime NVARCHAR(50)
	,@JobCode NVARCHAR(50),@TypeBime INT,@Sh_hesabPasAndaz NVARCHAR(50)='',@Sh_hesabPasKarFarma NVARCHAR(50)='',@AnvaEstekhdam INT,@EsargariId INT
	,@ChartOrgan INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKomakGheyerNaghdi] 
	INSERT INTO [Pay].[tblKomakGheyerNaghdi] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldNoeMostamer], [fldMablagh], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId)
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldNoeMostamer, @fldMablagh, @fldKhalesPardakhti, @fldMaliyat, @fldUserId, @fldDesc, GETDATE(),@fldShomareHesabId
	if(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	SELECT @PrsPersonalId=fldPrs_PersonalInfoId,@fldCostCenterId=fldCostCenterId,@fldInsurance=fldInsuranceWorkShopId 
	,@ShomareBime=fldShomareBime,@JobCode=fldJobeCode,@TypeBime=fldTypeBimeId
	FROM Pay.Pay_tblPersonalInfo WHERE fldid=@fldPersonalId
		SELECT       @EsargariId=Prs.Prs_tblPersonalInfo.fldEsargariId, @ChartOrgan=Com.tblOrganizationalPostsEjraee.fldChartOrganId
	FROM            Prs.Prs_tblPersonalInfo INNER JOIN
                         Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId
						 WHERE Prs.Prs_tblPersonalInfo.fldid=@PrsPersonalId
	SELECT TOP(1) @AnvaEstekhdam=fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=@PrsPersonalId ORDER BY fldTarikh desc
	--SELECT @Sh_hesabPasAndaz=fldShomareHesabPersonal,@Sh_hesabPasKarFarma=fldShomareHesabKarfarma FROM Pay.tblShomareHesabPasAndaz WHERE fldPersonalId=@fldPersonalId
		SELECT    @Sh_hesabPasAndaz=Com.tblShomareHesabeOmoomi.fldShomareHesab,@Sh_hesabPasKarFarma= tblShomareHesabeOmoomi_1.fldShomareHesab 
FROM         Pay.tblShomareHesabPasAndaz INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS  tblShomareHesabeOmoomi_1 ON Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId
                      WHERE com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@fldPersonalId
	SELECT @IdMohasebat =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_PersonalInfo] 
	INSERT INTO Pay.tblMohasebat_PersonalInfo
	        ( fldId ,fldMohasebatId ,fldVamId ,fldEzafe_TatilKariId , fldMamuriyatId , fldSayerPardakhthaId ,fldCostCenterId ,fldInsuranceWorkShopId ,fldCodeShoghliBime ,fldTypeBimeId ,
	          fldAnvaEstekhdamId ,fldFiscalHeaderId ,fldMoteghayerHoghoghiId ,fldShomareHesabId ,fldShomareBime , fldShPasAndazPersonal ,fldShPasAndazKarFarma ,
	          fldHokmId ,fldTedadBime1 ,fldTedadBime2 ,fldTedadBime3 ,fldT_Asli ,fldT_70 ,fldT_60 ,fldHamsareKarmand ,fldMazad30Sal ,fldMohasebatEydiId ,
	          fldKomakGheyerNaghdiId,fldMorakhasiId , fldStatusIsargariId ,fldOrganId,fldUserId ,fldDesc , fldDate,fldChartOrganId)
	SELECT @IdMohasebat,NULL,NULL,NULL,NULL,NULL,@fldCostCenterId,@fldInsurance,@JobCode,@TypeBime,@AnvaEstekhdam,NULL,NULL,@fldShomareHesabId,@ShomareBime,@Sh_hesabPasAndaz,@Sh_hesabPasKarFarma,
	NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,@fldID,NULL,@EsargariId,Com.fn_OrganId(@PrsPersonalId),@fldUserId,@fldDesc,GETDATE(),@ChartOrgan
	IF (@@ERROR<>0)
		ROLLBACK

	end

	COMMIT
GO
