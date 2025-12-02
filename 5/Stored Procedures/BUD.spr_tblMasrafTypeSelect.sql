SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMasrafTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	set @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647

	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblMasrafType] 
	WHERE  fldId  like @Value AND fldOrganId LIKE @fldOrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblMasrafType] 
	WHERE fldDesc like  @Value AND fldOrganId LIKE @fldOrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblMasrafType]
	
	commit
GO
