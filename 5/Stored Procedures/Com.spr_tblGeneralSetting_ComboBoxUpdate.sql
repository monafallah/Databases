SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ComboBoxUpdate] 
    @fldId tinyint,
    @fldGeneralSettingId tinyint,
    @fldTtile nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200)
AS 

	BEGIN TRAN
	set @fldTtile=com.fn_TextNormalize(@fldTtile)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblGeneralSetting_ComboBox]
	SET    [fldGeneralSettingId] = @fldGeneralSettingId, [fldTtile] = @fldTtile, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
