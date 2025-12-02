SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblComboBoxSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblComboBox] 
	WHERE  fldId = @Value

    if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblComboBox] 
	WHERE  fldTitle like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblComboBox] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblComboBox] 

	COMMIT
GO
