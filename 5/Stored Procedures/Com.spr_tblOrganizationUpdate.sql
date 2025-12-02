SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationUpdate] 
    @fldId int,
    @fldName nvarchar(300),
    @fldPId int,
    @fldArm VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldFileId INT,
    @fldCityId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldCodAnformatic nvarchar(3)=NULL,
	@fldCodKhedmat tinyint,
	@fldAshkhaseHoghoghiId INT
AS 

	--BEGIN TRy
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	SET @fldCodAnformatic=Com.fn_TextNormalize(@fldCodAnformatic)

	IF(@fldArm IS NULL)
	UPDATE [Com].[tblOrganization]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldPId] = @fldPId, [fldFileId] = @fldFileId, [fldCityId] = @fldCityId,[fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldCodAnformatic=@fldCodAnformatic,fldCodKhedmat=@fldCodKhedmat,fldAshkhaseHoghoghiId=@fldAshkhaseHoghoghiId
	WHERE  [fldId] = @fldId
	
	ELSE
	BEGIN
	UPDATE [Com].[tblfile]
	SET    [fldId] = @fldFileId, [fldImage] = @fldArm, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldPasvand=@fldPasvand
	WHERE  [fldId] = @fldFileId
	
	UPDATE [Com].[tblOrganization]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldPId] = @fldPId, [fldFileId] = @fldFileId, [fldCityId] = @fldCityId,[fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldCodAnformatic=@fldCodAnformatic,fldCodKhedmat=@fldCodKhedmat,fldAshkhaseHoghoghiId=@fldAshkhaseHoghoghiId
	WHERE  [fldId] = @fldId
	END
COMMIT
--	END TRY
	
--	BEGIN CATCH

--    IF @@TRANCOUNT > 0
--	BEGIN
--	PRINT('rollback')
--        ROLLBACK
--	end
--END CATCH
GO
