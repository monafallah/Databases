SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ValueInsert] 
 
    @fldGeneralSettingId tinyint,
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldOrganId int
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID tinyint 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblGeneralSetting_Value] 

	INSERT INTO [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId])
	SELECT @fldId, @fldGeneralSettingId, @fldValue, @fldUserId, @fldDesc, getdate(), @fldOrganId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
