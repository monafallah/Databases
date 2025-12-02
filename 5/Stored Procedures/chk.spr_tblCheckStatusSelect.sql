SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheckStatusSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 
	WHERE  fldId = @Value


		if (@fieldname=N'fldSodorCheckId')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 
	WHERE [fldSodorCheckId] like  @Value
		
		
		if (@fieldname=N'fldCheckVaredeId')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 
	WHERE [fldCheckVaredeId] like  @Value
	
	
		if (@fieldname=N'fldAghsatId')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 
	WHERE fldAghsatId like  @Value


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldSodorCheckId], [fldCheckVaredeId], [fldAghsatId], [fldvaziat], [fldTarikh], [fldUserID], [fldDesc], [fldDate] 
	FROM   [chk].[tblCheckStatus] 

	COMMIT
GO
