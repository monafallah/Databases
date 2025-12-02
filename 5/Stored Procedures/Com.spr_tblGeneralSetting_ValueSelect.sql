SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSetting_ValueSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) gv.[fldId], [fldGeneralSettingId], gv.[fldValue], gv.[fldUserId], gv.[fldDesc],gv.[fldDate], gv.[fldOrganId] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_Value] gv inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId
	WHERE  gv.fldId=@Value and gv.fldorganId=@organId

	if (@FieldName='fldGeneralSettingId')
	SELECT top(@h) gv.[fldId], [fldGeneralSettingId], gv.[fldValue], gv.[fldUserId], gv.[fldDesc],gv.[fldDate], gv.[fldOrganId] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_Value] gv inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId
	WHERE  fldGeneralSettingId like @Value  and gv.fldorganId=@organId


	if (@FieldName='')
	SELECT top(@h) gv.[fldId], [fldGeneralSettingId], gv.[fldValue], gv.[fldUserId], gv.[fldDesc],gv.[fldDate], gv.[fldOrganId] 
	,g.fldName as fldNameGeneralSetting
	FROM   [Com].[tblGeneralSetting_Value] gv inner join com.tblGeneralSetting g
	on g.fldid=fldGeneralSettingId
	where  gv.fldorganId=@organId

	
	COMMIT
GO
