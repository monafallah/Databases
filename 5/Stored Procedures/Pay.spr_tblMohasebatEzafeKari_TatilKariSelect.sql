SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatEzafeKari_TatilKariSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  fldId = @Value AND Com.fn_MaxPersonalStatus(fldPersonalId,'Hoghoghi')=1 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  fldDesc LIKE @Value
	

	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  fldPersonalId = @Value AND Com.fn_MaxPersonalStatus(fldPersonalId,'Hoghoghi')=1 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	
	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  fldPersonalId = @Value AND Com.fn_MaxPersonalStatus(fldPersonalId,'Hoghoghi')=1

	
	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  fldYear = @Value AND Com.fn_MaxPersonalStatus(fldPersonalId,'Hoghoghi')=1 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldTedad], [fldMablagh], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeSakht], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldMashmolBime], [fldMashmolMaliyat], [fldNobatPardakht], [fldType], [fldKhalesPardakhti], [fldMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,case when(fldType=1) then N'اضافه کاری' when (fldType=2) then N'تعطیل کاری' end as fldTypeName
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari] 
	WHERE  Com.fn_MaxPersonalStatus(fldPersonalId,'Hoghoghi')=1 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	COMMIT
GO
