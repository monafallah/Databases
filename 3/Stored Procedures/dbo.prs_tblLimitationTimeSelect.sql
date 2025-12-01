SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationTimeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldRoozHafte], format([fldAzSaat],'0#:##')fldAzSaat, FORMAT([fldTaSaat],'0#:##')fldTaSaat, [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationTime] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldUserLimId], [fldRoozHafte], format([fldAzSaat],'0#:##')fldAzSaat, FORMAT([fldTaSaat],'0#:##')fldTaSaat, [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationTime] 
	WHERE  fldDesc=@Value

	if (@FieldName='fldUserLimId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldRoozHafte], format([fldAzSaat],'0#:##')fldAzSaat, FORMAT([fldTaSaat],'0#:##')fldTaSaat, [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationTime] 
	WHERE  fldUserLimId=@Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldUserLimId], [fldRoozHafte], format([fldAzSaat],'0#:##')fldAzSaat, FORMAT([fldTaSaat],'0#:##')fldTaSaat, [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationTime] 

	
	COMMIT
GO
