SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_MamuriyatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	WHERE  fldDesc LIKE @Value
	
	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	WHERE  fldPersonalId = @Value
	
	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	WHERE  fldPersonalId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	WHERE  fldYear = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'ALL')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedadBaBeytute], [fldTedadBedunBeytute], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBiKari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldKhalesPardakhti], [fldMaliyat], [fldTashilat], [fldNobatePardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Mamuriyat] 
	where Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId

	COMMIT
GO
