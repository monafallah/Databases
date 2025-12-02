SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[prs_tblPspModelSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPspId], [fldModel], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPspModel] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldPspId], [fldModel], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPspModel] 
	WHERE  dbo.fn_TextNormalizeSelect(fldName) like dbo.fn_TextNormalizeSelect( @Value)

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPspId], [fldModel], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPspModel] 

	COMMIT
GO
