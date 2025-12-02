SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldYear], [fldMonth], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel],  [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldkhalesPardakhti], [fldMaliyat],  [fldUserId], [fldDesc], [fldDate] ,fldHokmId
	FROM   [Pay].[tblMoavaghat] 
	WHERE  fldId = @Value
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldYear], [fldMonth], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel],  [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldkhalesPardakhti], [fldMaliyat],  [fldUserId], [fldDesc], [fldDate] ,fldHokmId
	FROM   [Pay].[tblMoavaghat] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldYear], [fldMonth], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel],  [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldkhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] ,fldHokmId
	FROM   [Pay].[tblMoavaghat] 
	WHERE  fldMohasebatId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldYear], [fldMonth], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldkhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] ,fldHokmId
	FROM   [Pay].[tblMoavaghat] 

	COMMIT
GO
