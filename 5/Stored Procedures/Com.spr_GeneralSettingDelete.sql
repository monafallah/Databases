SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Com].[spr_GeneralSettingDelete]
@fldid int,
@fldUserId int
as 
begin tran
delete from com.tblGeneralSetting_ComboBox
where fldGeneralSettingId=@fldid
if (@@error<>0)
	rollback
else
begin
	delete from com.tblGeneralSetting_Value
	where fldGeneralSettingId=@fldid
	if (@@ERROR<>0)
		rollback
	else
	begin
		update com.tblGeneralSetting 
		set fldUserId=@fldUserId ,fldDate=GETDATE()
		where fldid=@fldid
		if (@@ERROR<>0)
			rollback
		else
		begin
			delete from com.tblGeneralSetting
			where fldid=@fldid
			if (@@ERROR<>0)
				rollback

		end
	end

end
commit
GO
