SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceCompanySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldFileId], [fldUserId], [fldDate], [fldDesc],[fldOrganId],[fldIp]
	FROM   [Str].[tblInsuranceCompany] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldFileId], [fldUserId], [fldDate], [fldDesc],[fldOrganId],[fldIp]
	FROM   [Str].[tblInsuranceCompany] 
	WHERE  fldName LIKE @Value
	
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldFileId], [fldUserId], [fldDate], [fldDesc],[fldOrganId],[fldIp]
	FROM   [Str].[tblInsuranceCompany] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldFileId], [fldUserId], [fldDate], [fldDesc],[fldOrganId],[fldIp]
	FROM   [Str].[tblInsuranceCompany] 

	COMMIT
GO
