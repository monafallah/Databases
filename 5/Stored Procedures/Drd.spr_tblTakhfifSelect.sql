SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldShomareMojavez')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldShomareMojavez like  @Value

	if (@fieldname=N'fldAzTarikh')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldAzTarikh like  @Value

	if (@fieldname=N'fldTaTarikh')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldTaTarikh like  @Value

	if (@fieldname=N'fldTarikhMojavez')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldTarikhMojavez like  @Value

	if (@fieldname=N'fldTakhfifKoli')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldTakhfifKoli like  @Value

	if (@fieldname=N'fldTakhfifNaghdi')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldTakhfifNaghdi like  @Value


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblTakhfif] 

	COMMIT
GO
