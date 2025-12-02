SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifDetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfifDetail] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfifDetail] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'fldTakhfifId')
	SELECT top(@h) [fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfifDetail] 
	WHERE fldTakhfifId like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfifDetail] 

	COMMIT
GO
