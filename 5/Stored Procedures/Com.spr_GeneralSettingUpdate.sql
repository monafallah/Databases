SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_GeneralSettingUpdate]
	@fldHeaderId int,
    @fldName nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldOrganId int,
	@fldModuleId int,
	@ComboBox com.GeneralSettingComboBox  readonly

as

begin tran
declare @comboId tinyint
SET @fldName=com.fn_TextNormalize(@fldName)
SET @fldValue=com.fn_TextNormalize(@fldValue)
SET @fldDesc=com.fn_TextNormalize(@fldDesc)

/*DeleteSetting_ComboBox*/

	delete gc
	from com.tblGeneralSetting_ComboBox gc 
	left join @ComboBox c on gc.fldid=c.fldid
	where gc.fldGeneralSettingId=@fldHeaderId and c.fldid is null
	
	if (@@ERROR<>0)
		rollback
--------------------------------------------------------
/*UpdateGeneralSetting*/
	else
	begin
		UPDATE [Com].tblGeneralSetting
		SET    [fldName] = @fldName,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
		,fldModuleId=@fldModuleId
		WHERE  fldId=@fldHeaderId
		if (@@ERROR<>0)
			rollback
-------------------------------------------------------------
/*UpdateSetting_Value*/
		else
		begin
			UPDATE [Com].[tblGeneralSetting_Value]
			SET    [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
			WHERE  fldGeneralSettingId=@fldHeaderId and [fldOrganId] = @fldOrganId
			if (@@ERROR<>0)
				rollback
--------------------------------------------------------------------
/*UpdateSetting_ComboBox*/			
			else
			begin
				
				update ge
				set ge.fldTtile=com.fn_TextNormalize( co.fldTtile),ge.fldValue=com.fn_TextNormalize( co.fldValue)
				from com.tblGeneralSetting_ComboBox ge inner join @ComboBox co on co.fldid=ge.fldid
				where fldGeneralSettingId=@fldHeaderId and co.fldid<>0
				if (@@ERROR<>0)
					rollback
-----------------------------------------------------------------------
/*InsertSetting_ComboBox*/			
				else
				begin
					select @comboId =ISNULL(max(fldId),0) from [Com].[tblGeneralSetting_ComboBox] 
					INSERT INTO [Com].[tblGeneralSetting_ComboBox] ([fldId], [fldGeneralSettingId], [fldTtile], [fldValue], [fldUserId], [fldDesc], [fldDate])
					SELECT ROW_NUMBER()over (order by (select 1))+@comboId, @fldHeaderid, com.fn_TextNormalize(fldTtile), com.fn_TextNormalize(fldValue), @fldUserId, '', getdate() 
					from @ComboBox where fldid=0  and fldid is not null
					if(@@Error<>0)
						rollback  
				end
			end
		end
	end

commit
GO
