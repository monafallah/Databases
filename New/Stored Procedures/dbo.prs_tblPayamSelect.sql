SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPayamSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	WHERE  fldId=@value
	order by fldId desc
	
	if (@fieldname='fldNameShakhs')
	SELECT top(@h)[fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	WHERE  fldNameShakhs like @value
	order by fldId desc
	
	if (@fieldname='fldMobile')
	SELECT top(@h)[fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	WHERE  fldMobile like @value
	order by fldId desc
	
	if (@fieldname='fldEmail')
	SELECT top(@h)[fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	WHERE  fldEmail like @value
	order by fldId desc
	
	if (@fieldname='fldSubject')
	SELECT top(@h)[fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	WHERE  fldSubject like @value
	order by fldId desc
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn],  [fldDate] 
	FROM   [dbo].[tblPayam] 
	order by fldId desc
	


	COMMIT
GO
