SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblOperationSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblOperation] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblOperation] 
	WHERE fldDesc LIKE  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblOperation] 

	COMMIT
GO
