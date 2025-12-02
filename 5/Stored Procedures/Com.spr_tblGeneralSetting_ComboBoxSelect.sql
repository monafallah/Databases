SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ComboBoxSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) gc.[fldId], gc.[fldGeneralSettingId], gc.[fldTtile],gc. [fldValue], gc.[fldUserId], gc.[fldDesc], gc.[fldDate] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_ComboBox]gc inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId
	WHERE  gc.fldId=@Value

	if (@FieldName='fldGeneralSettingId')
	SELECT top(@h) gc.[fldId], gc.[fldGeneralSettingId], gc.[fldTtile],gc. [fldValue], gc.[fldUserId], gc.[fldDesc], gc.[fldDate] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_ComboBox]gc inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId
	WHERE  fldGeneralSettingId like @Value

	if (@FieldName='')
	SELECT top(@h) gc.[fldId], gc.[fldGeneralSettingId], gc.[fldTtile],gc. [fldValue], gc.[fldUserId], gc.[fldDesc], gc.[fldDate] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_ComboBox]gc inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId

	
	COMMIT
GO
