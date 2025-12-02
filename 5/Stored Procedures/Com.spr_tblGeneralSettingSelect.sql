SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSettingSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h)g. [fldId], [fldName],v.[fldValue], g.[fldUserId],g. [fldDesc], g.[fldDate], v.[fldOrganId],fldModuleId 
	,isnull(m.fldTitle ,'') fldNameModule,isnull(combo.fldTtile,'')fldTitleCombo
	FROM   [Com].tblGeneralSetting  g 
	left join com.tblModule m on m.fldid=fldModuleId
	left join com.tblGeneralSetting_Value as v on v.fldGeneralSettingId=g.fldId
	outer apply (select  fldTtile from com.tblGeneralSetting_ComboBox c where fldGeneralSettingId=g.fldid and c.fldValue=v.fldValue)combo
	WHERE  g.fldId=@Value 

	if (@FieldName='fldName')
SELECT top(@h)g. [fldId], [fldName],v.[fldValue], g.[fldUserId],g. [fldDesc], g.[fldDate], v.[fldOrganId],fldModuleId 
	,isnull(m.fldTitle ,'') fldNameModule,isnull(combo.fldTtile,'')fldTitleCombo
	FROM   [Com].tblGeneralSetting  g 
	left join com.tblModule m on m.fldid=fldModuleId
	left join com.tblGeneralSetting_Value as v on v.fldGeneralSettingId=g.fldId
	outer apply (select  fldTtile from com.tblGeneralSetting_ComboBox c where fldGeneralSettingId=g.fldid and c.fldValue=v.fldValue)combo

	WHERE  fldName like @Value and v.[fldOrganId]=@OrganId

		if (@FieldName='fldDesc')
	SELECT top(@h)g. [fldId], [fldName],v.[fldValue], g.[fldUserId],g. [fldDesc], g.[fldDate], v.[fldOrganId],fldModuleId 
	,isnull(m.fldTitle ,'') fldNameModule,isnull(combo.fldTtile,'')fldTitleCombo
	FROM   [Com].tblGeneralSetting  g 
	left join com.tblModule m on m.fldid=fldModuleId
	left join com.tblGeneralSetting_Value as v on v.fldGeneralSettingId=g.fldId
	outer apply (select fldTtile from com.tblGeneralSetting_ComboBox c where fldGeneralSettingId=g.fldid and c.fldValue=v.fldValue)combo

	WHERE  m.fldDesc like @Value and v.[fldOrganId]=@OrganId


	if (@FieldName='fldModuleId')
	SELECT top(@h)g. [fldId], [fldName],v.[fldValue], g.[fldUserId],g. [fldDesc], g.[fldDate], v.[fldOrganId],fldModuleId 
	,isnull(m.fldTitle ,'') fldNameModule,isnull(combo.fldTtile,'')fldTitleCombo
	FROM   [Com].tblGeneralSetting  g 
	left join com.tblModule m on m.fldid=fldModuleId
	left join com.tblGeneralSetting_Value as v on v.fldGeneralSettingId=g.fldId
outer apply (select  fldTtile from com.tblGeneralSetting_ComboBox c where fldGeneralSettingId=g.fldid and c.fldValue=v.fldValue)combo

	WHERE  fldModuleId like @Value and v.[fldOrganId]=@OrganId

	if (@FieldName='')
	SELECT top(@h)g. [fldId], [fldName],v.[fldValue], g.[fldUserId],g. [fldDesc], g.[fldDate], v.[fldOrganId],fldModuleId 
	,isnull(m.fldTitle ,'') fldNameModule,isnull(combo.fldTtile,'')fldTitleCombo
	FROM   [Com].tblGeneralSetting  g 
	left join com.tblModule m on m.fldid=fldModuleId
	left join com.tblGeneralSetting_Value as v on v.fldGeneralSettingId=g.fldId
	outer apply (select  fldTtile from com.tblGeneralSetting_ComboBox c where fldGeneralSettingId=g.fldid and c.fldValue=v.fldValue)combo

	where   v.[fldOrganId]=@OrganId
	
	COMMIT
GO
