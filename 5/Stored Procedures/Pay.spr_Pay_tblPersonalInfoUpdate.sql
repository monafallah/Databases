SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_tblPersonalInfoUpdate] 
    @fldId int,
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
    @fldTarikhMazad30Sal int
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[Pay_tblPersonalInfo]
	SET    [fldId] = @fldId, [fldPrs_PersonalInfoId] = @fldPrs_PersonalInfoId, [fldTypeBimeId] = @fldTypeBimeId, [fldShomareBime] = @fldShomareBime, [fldBimeOmr] = @fldBimeOmr, [fldBimeTakmili] = @fldBimeTakmili, [fldMashagheleSakhtVaZianAvar] = @fldMashagheleSakhtVaZianAvar, [fldCostCenterId] = @fldCostCenterId, [fldMazad30Sal] = @fldMazad30Sal, [fldPasAndaz] = @fldPasAndaz, [fldSanavatPayanKhedmat] = @fldSanavatPayanKhedmat, [fldJobeCode] = @fldJobeCode, [fldInsuranceWorkShopId] = @fldInsuranceWorkShopId, [fldHamsarKarmand] = @fldHamsarKarmand, [fldMoafDarman] = @fldMoafDarman, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	,fldTarikhMazad30Sal=@fldTarikhMazad30Sal
    WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
