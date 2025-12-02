SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_GeneralSettingInsert]

    @fldName nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldOrganId int,
	@fldModuleId int,
	@ComboBox com.GeneralSettingComboBox  readonly 
	
as
begin tran 
declare @fldHeaderid int,@comboId tinyint,@ValueId int

SET @fldName=com.fn_TextNormalize(@fldName)
SET @fldValue=com.fn_TextNormalize(@fldValue)
SET @fldDesc=com.fn_TextNormalize(@fldDesc)

/*insert tblGeneralSetting*/
	select @fldHeaderid =ISNULL(max(fldId),0)+1 from [Com].tblGeneralSetting 
	INSERT INTO [Com].tblGeneralSetting ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate],fldModuleId,fldOrganId)
	SELECT @fldHeaderid, @fldName, '', @fldUserId, @fldDesc, getdate(),@fldModuleId,@fldOrganId
	if (@@error<>0)
		rollback
----------------------------------------------------------------
	else 
	begin
		/*tblGeneralSetting_ComboBox*/
		select @comboId =ISNULL(max(fldId),0) from [Com].[tblGeneralSetting_ComboBox] 
		INSERT INTO [Com].[tblGeneralSetting_ComboBox] ([fldId], [fldGeneralSettingId], [fldTtile], [fldValue], [fldUserId], [fldDesc], [fldDate])
		SELECT ROW_NUMBER()over (order by (select 1))+@comboId, @fldHeaderid, com.fn_TextNormalize(fldTtile), com.fn_TextNormalize(fldValue), @fldUserId, @fldDesc, getdate() 
		from @ComboBox where fldid is not null
		if(@@Error<>0)
			rollback  
		else
		begin
			/*tblGeneralSetting_Value*/
			select @ValueId =ISNULL(max(fldId),0)+1 from [Com].[tblGeneralSetting_Value] 
			INSERT INTO [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId])
			SELECT @ValueId, @fldHeaderid, @fldValue, @fldUserId, @fldDesc, getdate(), @fldOrganId
			if(@@Error<>0)
				rollback  
		end 

	end

commit
GO
