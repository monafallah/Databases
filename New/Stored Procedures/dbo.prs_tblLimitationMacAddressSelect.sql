SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationMacAddressSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldMacValid], [fldDesc] 
	FROM   [dbo].[tblLimitationMacAddress] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldUserLimId], [fldMacValid], [fldDesc] 
	FROM   [dbo].[tblLimitationMacAddress] 
	WHERE  fldDesc=@Value

		if (@FieldName='fldMacValid')
	SELECT top(@h) [fldId], [fldUserLimId], [fldMacValid], [fldDesc] 
	FROM   [dbo].[tblLimitationMacAddress] 
	WHERE  fldMacValid like @Value

	if (@FieldName='fldUserLimId')
	SELECT top(@h) [fldId], [fldUserLimId], [fldMacValid], [fldDesc] 
	FROM   [dbo].[tblLimitationMacAddress] 
	WHERE  fldUserLimId=@Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldUserLimId], [fldMacValid], [fldDesc] 
	FROM   [dbo].[tblLimitationMacAddress] 

	
	COMMIT
GO
