SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldDesc like @Value and fldOrganId =@OrganId

	if (@FieldName='fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldTitle like @Value and fldOrganId =@OrganId

	if (@FieldName='fldDarsadBimePeymankar')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldDarsadBimePeymankar like @Value and fldOrganId =@OrganId

	if (@FieldName='fldDarsadBimeKarfarma')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldDarsadBimeKarfarma like @Value and fldOrganId =@OrganId

	if (@FieldName='fldDarsadAnjamKar')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldDarsadAnjamKar like @Value and fldOrganId =@OrganId

	if (@FieldName='fldDarsadZemanatName')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	WHERE  fldDarsadZemanatName like @Value and fldOrganId =@OrganId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	
	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	FROM   [cntr].[tblContractType] 
	where  fldOrganId =@OrganId
	
	COMMIT
GO
