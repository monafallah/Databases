SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPageHtmlSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value= dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldMasir], [fldMohtavaHtml], [fldDesc]
	FROM   [dbo].[tblPageHtml] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldMasir], [fldMohtavaHtml], [fldDesc]
	FROM   [dbo].[tblPageHtml] 
	WHERE  fldTitle like @Value

	if (@fieldname=N'fldMasir')
	SELECT top(@h) [fldId], [fldTitle], [fldMasir], [fldMohtavaHtml], [fldDesc]
	FROM   [dbo].[tblPageHtml] 
	WHERE  fldMasir like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldMasir], [fldMohtavaHtml],[fldDesc]
	FROM   [dbo].[tblPageHtml] 

	COMMIT
GO
