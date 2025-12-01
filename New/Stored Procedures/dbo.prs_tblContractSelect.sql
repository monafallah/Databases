SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContractSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldTitle], [fldCreatedDate], [fldTechnologies], [fldImageUrl], [fldInputId], [fldDesc], [fldDate] ,fldDemoUrl,fldGitHubUrl,dbo.miladitoshamsi (fldCreatedDate) fldCreatedDateShamsi
	FROM   [dbo].[tblContract] 
	WHERE  fldId=@value

	if (@fieldname='fldTitle')
	SELECT top(@h)[fldId], [fldTitle], [fldCreatedDate], [fldTechnologies], [fldImageUrl], [fldInputId], [fldDesc], [fldDate] ,fldDemoUrl,fldGitHubUrl,dbo.miladitoshamsi (fldCreatedDate) fldCreatedDateShamsi
	FROM   [dbo].[tblContract] 
	WHERE  fldTitle like @value

	if (@fieldname='fldCreatedDateShamsi')
	SELECT top(@h)[fldId], [fldTitle], [fldCreatedDate], [fldTechnologies], [fldImageUrl], [fldInputId], [fldDesc], [fldDate] ,fldDemoUrl,fldGitHubUrl,dbo.miladitoshamsi (fldCreatedDate) fldCreatedDateShamsi
	FROM   [dbo].[tblContract] 
	WHERE  dbo.miladitoshamsi (fldCreatedDate) like @value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldTitle], [fldCreatedDate], [fldTechnologies], [fldImageUrl], [fldInputId], [fldDesc], [fldDate] ,fldDemoUrl,fldGitHubUrl,dbo.miladitoshamsi (fldCreatedDate) fldCreatedDateShamsi
	FROM   [dbo].[tblContract] 
	order by fldCreatedDate desc
	


	COMMIT
GO
