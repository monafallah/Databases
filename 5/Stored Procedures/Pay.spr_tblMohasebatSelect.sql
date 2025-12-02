SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@Value3 nvarchar(50),
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	SET @Value =Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	
	if (@fieldname=N'fldId')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  m.fldId = @Value  AND p.fldOrganId=@OrganId  

		if (@fieldname=N'SumMaliyat')
		SELECT count(*) as [fldId],0 [fldPersonalId], [fldYear], [fldMonth],cast(0 as tinyint) [fldKarkard],
		 cast(0 as tinyint)[fldGheybat],cast(0 as decimal) [fldTedadEzafeKar],cast(0 as decimal) [fldTedadTatilKar],cast(0 as tinyint) [fldBaBeytute]
		 ,cast(0 as tinyint) [fldBedunBeytute], 0 [fldBimeOmrKarFarma],0 [fldBimeOmr],0 [fldBimeTakmilyKarFarma],0 [fldBimeTakmily], 0[fldHaghDarmanKarfFarma]
		 ,0 [fldHaghDarmanDolat],0 [fldHaghDarman],0 [fldBimePersonal],0 [fldBimeKarFarma],0 [fldBimeBikari], 0 [fldBimeMashaghel],cast(0 as decimal) [fldDarsadBimePersonal]
		 ,cast(0 as decimal) [fldDarsadBimeKarFarma],cast(0 as decimal) [fldDarsadBimeBikari],cast(0 as decimal) [fldDarsadBimeSakht],cast(0 as tinyint) [fldTedadNobatKari]
		 ,0 [fldMosaede],0 [fldNobatPardakht],0 [fldGhestVam],0 [fldPasAndaz],0 [fldMashmolBime],0 [fldMashmolMaliyat],cast(0 as bit) [fldFlag]
		 ,0 [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon,0 [fldMogharari], 0 as [fldMaliyat],1 [fldUserId],'' [fldDesc],getdate()[fldDate] 
		,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,0 fldShift,0 fldShomareHesabId,0 as fldBankId,cast(0 as smallint)fldMeetingCount
		,cast(0 as tinyint)fldCalcType,sum(cast([fldMaliyat] as bigint)) as [fldMaliyatSum],0 fldEstelagi
		FROM   [Pay].[tblMohasebat] as m
		inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
		WHERE  fldYear=@Value and fldMonth=@Value2 and fldorganid=@OrganId and fldCalcType=1
		group by fldYear,fldMonth

	if (@fieldname=N'fldMohasebatId')
	select * from(
		SELECT  m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute]
		, [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat]
		, [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma]
		, [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime]
		, [fldMashmolMaliyat], [fldFlag], m.[fldkhalesPardakhti]+isnull(o.fldkhalesPardakhti,0)-isnull(i.fldMablaghItem,0)-isnull(oi.fldMablaghMoavagh,0)-isnull(mo.fldMablaghmo,0) as  fldkhalesPardakhti
		,isnull(i.fldMablaghItem,0)+isnull(oi.fldMablaghMoavagh,0)+isnull(mo.fldMablaghmo,0)-isnull(ko.fldMablaghko,0) as  fldkhalesPardakhtiBon
		, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
		,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount
		,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
		FROM   [Pay].[tblMohasebat] as m
		inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
		outer apply(select sum(fldMablagh) as fldMablaghItem  from pay.tblMohasebat_Items where fldMohasebatId=m.fldId and fldHesabTypeItemId=1)i
		outer apply(select sum(fldMablagh) as fldMablaghmo  from pay.[tblMohasebat_kosorat/MotalebatParam] where fldMohasebatId=m.fldId and fldHesabTypeParamId=1 and fldKosoratId  is  null)mo
		outer apply(select sum(fldMablagh) as fldMablaghko from pay.[tblMohasebat_kosorat/MotalebatParam] where fldMohasebatId=m.fldId and fldHesabTypeParamId=1 and fldMotalebatId is null)ko
		outer apply(select sum(o.fldkhalesPardakhti) as fldkhalesPardakhti
					from pay.tblMoavaghat as o 
					where o.fldMohasebatId=m.fldId
					)o
		outer apply(select sum(oi.fldMablagh) as fldMablaghMoavagh  from pay.tblMoavaghat as o 
					left join pay.tblMoavaghat_Items as oi on oi.fldMoavaghatId=o.fldId and fldHesabTypeItemId=1
					where o.fldMohasebatId=m.fldId
					)oi
		WHERE m.fldId = @Value )t
		where fldkhalesPardakhti<0 or fldkhalesPardakhtiBon<0

	IF (@fieldname=N'PersonCalc')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=fldShomareHesabId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldPersonalId=@Value3  

	IF (@fieldname=N'PersonCalcMotamam')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=fldShomareHesabId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldPersonalId=@Value3  and fldCalcType=1 and fldFlag=1
	
	IF (@fieldname=N'AllPersonCalcMotamam')
	SELECT  m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], m.[fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], m.[fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=fldShomareHesabId
	INNER JOIN Pay.Pay_tblPersonalInfo as pay ON  m.fldPersonalId = Pay.fldId
	cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = pay.fldPrs_PersonalInfoId) 
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
	WHERE  fldYear = @h  and fldMonth=@Value and fldOrganId=@OrganId  and fldCalcType=1 and fldFlag=1
	and ( @value2='' or exists (select item from com.Split(@value2,',') where item=p.fldCostCenterId ))
							   and ( @Value3='' or exists (select item from com.Split(@Value3,',') where item=fldAnvaeEstekhdamId ))


		if (@fieldname=N'fldDesc')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  m.fldDesc LIKE @Value
	

	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldPersonalId = @Value AND p.fldOrganId=@OrganId  
	
	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldPersonalId = @Value 

		
	IF (@fieldname=N'fldYear')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value  AND p.fldOrganId=@OrganId  

	IF (@fieldname=N'Fish')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=fldShomareHesabId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldNobatPardakht=@Value3  AND p.fldOrganId=@OrganId  

	IF (@fieldname=N'CheckMohasebat')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldNobatPardakht=@Value3  AND p.fldOrganId=@OrganId  

	IF (@fieldname=N'CheckMohasebat_Maliyat')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2   AND p.fldOrganId=@OrganId  
	and fldMaliyatCalc is not null

	IF (@fieldname=N'CheckMohasebat_Maliyat_PersonalId')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,fldShomareHesabId,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2   AND p.fldOrganId=@OrganId    and fldPersonalId=@h
	and fldMaliyatCalc is not null

	IF (@fieldname=N'CheckMaliyat')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldNobatPardakht=@Value3  AND p.fldOrganId=@OrganId  
	and fldMaliyatCalc is null and fldMaliyatCalc=2

	IF (@fieldname=N'CheckMaliyat_PersonalId')
	SELECT  m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2 and fldNobatPardakht=@Value3  AND p.fldOrganId=@OrganId  and fldPersonalId=@h
	and fldMaliyatCalc is null

	IF (@fieldname=N'CheckMaliyat_Variz')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2   AND p.fldOrganId=@OrganId  
	and fldMaliyatCalc is null and fldMaliyatCalc=2

	IF (@fieldname=N'CheckMaliyat_Variz_PersonalId')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2   AND p.fldOrganId=@OrganId   and fldPersonalId=@h
	and fldMaliyatCalc is null

	IF (@fieldname=N'CheckUploadFile')/*دیسکت بانک,دارایی*/
	SELECT m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  fldYear = @Value and fldMonth=@Value2  and fldNobatPardakht=@Value3   AND p.fldOrganId=@OrganId  
	and exists (select * from [Pay].[tblLogBastanHoghugh] as l where l.fldYear=m.fldYear and l.fldMonth=m.fldMonth 
	and l.fldOrganId=p.fldOrganId and fldType=@h and l.fldNobatPardkht=@Value3)

	if (@fieldname=N'')
	SELECT top(@h) m.[fldId], [fldPersonalId], [fldYear], [fldMonth], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute],  [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldDarsadBimePersonal], [fldDarsadBimeKarFarma], [fldDarsadBimeBikari], [fldDarsadBimeSakht], [fldTedadNobatKari], [fldMosaede], [fldNobatPardakht], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldFlag], [fldkhalesPardakhti],0 as fldkhalesPardakhtiBon, [fldMogharari], [fldMaliyat], m.[fldUserId], m.[fldDesc], m.[fldDate] 
	,Com.fn_month(fldMonth) AS fldNameMonth,0 AS fldJamhoghogh,fldShift,fldShomareHesabId,0 as fldBankId,fldMeetingCount,fldCalcType,cast(0 as bigint) as [fldMaliyatSum],fldEstelagi
	FROM   [Pay].[tblMohasebat] as m
	inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	WHERE  p.fldOrganId=@OrganId  

	COMMIT
GO
