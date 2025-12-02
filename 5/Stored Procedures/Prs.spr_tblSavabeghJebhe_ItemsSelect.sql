SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_ItemsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblSavabeghJebhe_Items] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblSavabeghJebhe_Items] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblSavabeghJebhe_Items] 
	WHERE  fldTitle like @Value

	if (@fieldname=N'fldDarsad_Sal')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblSavabeghJebhe_Items] 
	WHERE  fldDarsad_Sal like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblSavabeghJebhe_Items] 

	COMMIT
GO
