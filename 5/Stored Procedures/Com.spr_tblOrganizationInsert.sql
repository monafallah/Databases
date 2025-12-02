SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationInsert] 
    
    @fldName nvarchar(300),
    @fldPId int,
    @fldArm VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldCityId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldCodAnformatic nvarchar(3),
	@fldCodKhedmat tinyint,
	@fldAshkhaseHoghoghiId INT
AS 
	
	--BEGIN TRy
	declare @FileID int ,@fldId INT,@IdSetting INT,@flag BIT=0
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)

	BEGIN TRANSACTION
	select @FileID =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO Com.tblFile (fldid,fldImage,fldPasvand,flduserid,flddesc,flddate)
	SELECT @FileID,@fldArm,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblOrganization] 
	INSERT INTO [Com].[tblOrganization] ([fldId], [fldName], [fldPId], [fldFileId], [fldCityId],[fldUserId], [fldDesc], [fldDate],fldCodAnformatic,fldCodKhedmat,fldAshkhaseHoghoghiId)
	SELECT @fldId, @fldName, @fldPId, @FileID, @fldCityId,@fldUserId, @fldDesc, GETDATE(),@fldCodAnformatic,@fldCodKhedmat,@fldAshkhaseHoghoghiId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	select @IdSetting =ISNULL(max(fldId),0)+1 from [Pay].[tblSetting]
	INSERT INTO Pay.tblSetting
	        ( fldId ,fldH_BankFixId ,fldH_NameShobe ,fldH_CodeOrgan ,fldH_CodeShobe ,fldShowBankLogo ,fldOrganId ,fldCodeEghtesadi ,fldPrs_PersonalId ,
	          fldCodeParvande ,fldCodeOrganPasAndaz , fldSh_HesabCheckId ,fldB_BankFixId ,fldB_NameShobe ,fldB_ShomareHesabId ,fldB_CodeShenasaee ,fldUserId ,fldDesc ,fldDate)
	SELECT @IdSetting,NULL,'','','',0,@fldId,'',NULL,'','',NULL,NULL,'',NULL,'',@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	COMMIT TRANSACTION
--	END TRY
--BEGIN CATCH

--    IF @@TRANCOUNT > 0
--	BEGIN
--	PRINT('rollback')
--        ROLLBACK
--	end
--END CATCH
GO
