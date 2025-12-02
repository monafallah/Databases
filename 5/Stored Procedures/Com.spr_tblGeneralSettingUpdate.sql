SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSettingUpdate] 
    @fldId tinyint,
    @fldName nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),
    
    @fldOrganId int,
	@fldModuleId int
AS 

	BEGIN TRAN
	SET @fldName=com.fn_TextNormalize(@fldName)
	SET @fldValue=com.fn_TextNormalize(@fldValue)
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].tblGeneralSetting
	SET    [fldName] = @fldName, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldModuleId=@fldModuleId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
