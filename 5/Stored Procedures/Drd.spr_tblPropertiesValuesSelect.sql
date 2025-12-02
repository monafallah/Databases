SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPropertiesValuesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPropertiesId], [fldElamAvarezId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPropertiesValues] 
	WHERE  fldId = @Value



	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPropertiesId], [fldElamAvarezId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPropertiesValues] 

	COMMIT
GO
