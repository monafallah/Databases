SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCharacterPersianPlaqueSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblCharacterPersianPlaque] 
	WHERE  fldId=@Value

	if (@FieldName='fldName')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblCharacterPersianPlaque] 
	WHERE  fldName like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblCharacterPersianPlaque] 

	
	COMMIT
GO
