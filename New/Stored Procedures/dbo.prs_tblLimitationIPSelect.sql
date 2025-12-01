SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationIPSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldIPValid], [fldDesc] ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationIP] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldUserLimId], [fldIPValid], [fldDesc] ,cast(fldTimestamp as int)fldTimestamp 
	FROM   [dbo].[tblLimitationIP] 
	WHERE  fldDesc=@Value

	if (@FieldName='fldUserLimId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldIPValid], [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationIP] 
	WHERE  fldUserLimId=@Value


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldUserLimId], [fldIPValid], [fldDesc]  ,cast(fldTimestamp as int)fldTimestamp
	FROM   [dbo].[tblLimitationIP] 

	
	COMMIT
GO
