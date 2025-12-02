SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblElamAvarez_ModuleOrganSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 
	WHERE  fldId=@Value

	if (@FieldName='fldElamAvarezId')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 
	WHERE  fldElamAvarezId=@Value

	if (@FieldName='fldCodeDaramdElamAvarezId')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 
	WHERE  fldCodeDaramdElamAvarezId=@Value

	if (@FieldName='fldModulOrganId')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 
	WHERE  fldModulOrganId=@Value


	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 
	WHERE  fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Weigh].[tblElamAvarez_ModuleOrgan] 

	
	COMMIT
GO
