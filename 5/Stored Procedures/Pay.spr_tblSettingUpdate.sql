SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSettingUpdate] 
    @fldId int,
    @fldH_BankFixId int,
    @fldH_NameShobe nvarchar(250),
    @fldH_CodeOrgan nvarchar(50),
    @fldH_CodeShobe nvarchar(50),
    @fldShowBankLogo bit,
    @fldOrganId int,
    @fldCodeEghtesadi nvarchar(20),
    @fldPrs_PersonalId int,
    @fldCodeParvande nvarchar(50),
    @fldCodeOrganPasAndaz nvarchar(50),
    @fldSh_HesabCheckId int,
    @fldB_BankFixId int,
    @fldB_NameShobe nvarchar(250),
    @fldB_ShomareHesabId int,
    @fldB_CodeShenasaee nvarchar(50),
    @fldCodeDastgah NVARCHAR(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldP_BankFixId int,
    @fldP_ShobeId int,
	@fldStatusMahalKedmatId tinyint
AS 
	BEGIN TRAN
	SET @fldH_NameShobe=Com.fn_TextNormalize(@fldH_NameShobe)
	SET @fldB_NameShobe=Com.fn_TextNormalize(@fldB_NameShobe)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblSetting]
	SET    [fldId] = @fldId, [fldH_BankFixId] = @fldH_BankFixId, [fldH_NameShobe] = @fldH_NameShobe, [fldH_CodeOrgan] = @fldH_CodeOrgan, [fldH_CodeShobe] = @fldH_CodeShobe, [fldShowBankLogo] = @fldShowBankLogo, [fldOrganId] = @fldOrganId, [fldCodeEghtesadi] = @fldCodeEghtesadi, [fldPrs_PersonalId] = @fldPrs_PersonalId, [fldCodeParvande] = @fldCodeParvande, [fldCodeOrganPasAndaz] = @fldCodeOrganPasAndaz, [fldSh_HesabCheckId] = @fldSh_HesabCheckId, [fldB_BankFixId] = @fldB_BankFixId, [fldB_NameShobe] = @fldB_NameShobe, [fldB_ShomareHesabId] = @fldB_ShomareHesabId, [fldB_CodeShenasaee] = @fldB_CodeShenasaee, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldCodeDastgah=@fldCodeDastgah
	, [fldP_BankFixId] = @fldP_BankFixId, fldP_ShobeId = @fldP_ShobeId,fldStatusMahalKedmatId=@fldStatusMahalKedmatId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
