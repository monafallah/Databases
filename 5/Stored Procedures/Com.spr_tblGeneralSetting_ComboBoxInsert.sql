SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ComboBoxInsert] 

    @fldGeneralSettingId tinyint,
    @fldTtile nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200)
AS 

	
	BEGIN TRAN
	set @fldTtile=com.fn_TextNormalize(@fldTtile)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID tinyint 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblGeneralSetting_ComboBox] 

	INSERT INTO [Com].[tblGeneralSetting_ComboBox] ([fldId], [fldGeneralSettingId], [fldTtile], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldGeneralSettingId, @fldTtile, @fldValue, @fldUserId, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
