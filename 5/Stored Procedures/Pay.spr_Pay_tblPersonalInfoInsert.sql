SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_tblPersonalInfoInsert] 

    @fldPrs_PersonalInfoId int,
    @fldTypeBimeId int,
    @fldShomareBime nvarchar(10),
    @fldBimeOmr bit,
    @fldBimeTakmili bit,
    @fldMashagheleSakhtVaZianAvar bit,
    @fldCostCenterId int,
    @fldMazad30Sal bit,
    @fldPasAndaz bit,
    @fldSanavatPayanKhedmat bit,
    @fldJobeCode nvarchar(6),
    @fldInsuranceWorkShopId int,
    @fldHamsarKarmand bit,
    @fldMoafDarman bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldStatusId INT,
    @fldDateTaghirVaziyat NVARCHAR(10),
	@fldTarikhMazad30Sal int
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @IDPersonalStatus INT,@flag BIT=0,@fldId INT
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[Pay_tblPersonalInfo] 
	INSERT INTO [Pay].[Pay_tblPersonalInfo] ([fldId], [fldPrs_PersonalInfoId], [fldTypeBimeId], [fldShomareBime], [fldBimeOmr], [fldBimeTakmili], [fldMashagheleSakhtVaZianAvar], [fldCostCenterId], [fldMazad30Sal], [fldPasAndaz], [fldSanavatPayanKhedmat], [fldJobeCode], [fldInsuranceWorkShopId], [fldHamsarKarmand], [fldMoafDarman], [fldUserId], [fldDate], [fldDesc],fldTarikhMazad30Sal)
	SELECT @fldId, @fldPrs_PersonalInfoId, @fldTypeBimeId, @fldShomareBime, @fldBimeOmr, @fldBimeTakmili, @fldMashagheleSakhtVaZianAvar, @fldCostCenterId, @fldMazad30Sal, @fldPasAndaz, @fldSanavatPayanKhedmat, @fldJobeCode, @fldInsuranceWorkShopId, @fldHamsarKarmand, @fldMoafDarman, @fldUserId, GETDATE(), @fldDesc,@fldTarikhMazad30Sal
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF (@flag=0)
	BEGIN
		select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
		INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
		SELECT @IDPersonalStatus,@fldStatusId,NULL,@fldID,@fldDateTaghirVaziyat,@fldUserId,@fldDesc,GETDATE()
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END

	COMMIT
GO
