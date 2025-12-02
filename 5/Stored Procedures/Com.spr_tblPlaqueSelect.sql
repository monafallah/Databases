SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPlaqueSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldSerial_Plaque
	FROM   [Com].[tblPlaque] 
	WHERE  fldId=@Value

	if (@FieldName='fldPlaque')
	SELECT top(@h) [fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldSerial_Plaque
	FROM   [Com].[tblPlaque] 
	WHERE  fldPlaque like @Value

	if (@FieldName='fldSerial_Plaque')
	SELECT top(@h)* from (select  [fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldSerial_Plaque
	FROM   [Com].[tblPlaque] )t
	WHERE cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque like @value


	if (@FieldName='fldSerialPlaque')
	SELECT top(@h) [fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque as fldSerial_Plaque
	FROM   [Com].[tblPlaque] 
	WHERE  fldSerialPlaque like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque--'98 '+'-'+ '235'+N'ب'+'12'  
	as fldSerial_Plaque
	FROM   [Com].[tblPlaque] 

	
	COMMIT
GO
