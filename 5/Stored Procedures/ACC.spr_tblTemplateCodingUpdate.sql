SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateCodingUpdate] 
    @fldId int,
    
    @fldItemId int,
    @fldName nvarchar(200),
    @fldMahiyatId int,
    @fldCode VARCHAR(100),
    @fldTempNameId int,
    @fldLevelsAccountTypId int,
	@fldTypeHesabId tinyint,
    @fldDesc nvarchar(MAX),
    @fldIp varchar(16),
    @fldUserId int,
	@fldCodeBudget VARCHAR(100),
	@fldAddChildNode bit,
	@fldMahiyat_GardeshId int
AS 
	BEGIN TRAN
	
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldCode=Com.fn_TextNormalize(@fldCode)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblTemplateCoding]
	SET    [fldId] = @fldId,  [fldItemId] = @fldItemId, [fldName] = @fldName,fldTypeHesabId=@fldTypeHesabId,   [fldMahiyatId] = @fldMahiyatId, [fldCode] = @fldCode, [fldTempNameId] = @fldTempNameId, [fldLevelsAccountTypId] = @fldLevelsAccountTypId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	,fldCodeBudget=@fldCodeBudget,fldAddChildNode=@fldAddChildNode,fldMahiyat_GardeshId=@fldMahiyat_GardeshId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
