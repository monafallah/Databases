SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAnvaGroupTashvighiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblAnvaGroupTashvighi] 
	WHERE  fldId = @Value
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblAnvaGroupTashvighi] 
	WHERE  fldDesc LIKE @Value
	

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblAnvaGroupTashvighi] 
	WHERE  fldTitle LIKE @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblAnvaGroupTashvighi] 

	COMMIT
GO
