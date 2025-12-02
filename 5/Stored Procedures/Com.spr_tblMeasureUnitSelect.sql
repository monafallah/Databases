SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMeasureUnitSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldNameVahed], [fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblMeasureUnit] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldNameVahed')
	SELECT top(@h) [fldId], [fldNameVahed], [fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblMeasureUnit] 
	WHERE  fldNameVahed like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldNameVahed], [fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblMeasureUnit] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldNameVahed], [fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblMeasureUnit] 

	COMMIT
GO
