SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ValueUpdate] 
    @fldId tinyint,
    @fldGeneralSettingId tinyint,
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),

    @fldOrganId int
AS 

	BEGIN TRAN
		set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblGeneralSetting_Value]
	SET    [fldGeneralSettingId] = @fldGeneralSettingId, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldOrganId] = @fldOrganId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
