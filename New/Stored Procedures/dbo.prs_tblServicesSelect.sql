SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblServicesSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate] 
	FROM   [dbo].[tblServices] 
	WHERE  fldId=@value
	
	if (@fieldname='fldTitle')
	SELECT top(@h)[fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate] 
	FROM   [dbo].[tblServices] 
	WHERE  fldTitle like @value
	
	if (@fieldname='fldIconUrl')
	SELECT top(@h)[fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate] 
	FROM   [dbo].[tblServices] 
	WHERE  fldIconUrl like @value
	
	if (@fieldname='fldDetailedDescription')
	SELECT top(@h)[fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate] 
	FROM   [dbo].[tblServices] 
	WHERE  fldDetailedDescription like @value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate] 
	FROM   [dbo].[tblServices] 
	


	COMMIT
GO
