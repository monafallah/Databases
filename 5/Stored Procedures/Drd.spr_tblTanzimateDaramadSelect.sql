SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTanzimateDaramadSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fiscalyearId int,
	@h int
AS 
	BEGIN TRAN

	declare @year smallint,@organId int--,@fiscalyearId int
	select @year=fldYear,@organId=fldOrganId from acc.tblFiscalYear where  fldid=@fiscalyearId
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
select  Drd.tblTanzimateDaramad.fldId, isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,  
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
	WHERE  tblTanzimateDaramad.fldId = @Value


if (@fieldname=N'fldOrganId')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join*/ 
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
	WHERE  tblTanzimateDaramad.fldOrganId = @Value


	if (@fieldname=N'fldOrganId_HesabRayan')/*برای شاهرودمالیات  عوارض آیدی ثایت دارن */
select top(@h) Drd.tblTanzimateDaramad.fldId,    3 fldAvarezId, 2  fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, N'عوارض'  AS fldTitle_CodeAvarez, 
                     N'مالیات' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join*/ 
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	--outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	--outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
	WHERE  tblTanzimateDaramad.fldOrganId = @Value

	if (@fieldname=N'fldOrganId_Check')/*fargh dare*/
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, ''  AS fldTitle_CodeAvarez, 
                     ''  AS fldTitle_CodeMaliyat,
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join*/ 
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	/*outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT*/
	WHERE  tblTanzimateDaramad.fldOrganId = @Value


if (@fieldname=N'fldTakhirId')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
	WHERE  fldTakhirId = @Value


if (@fieldname=N'fldMaliyatId')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
	WHERE  fldMaliyatId = @Value


if (@fieldname=N'fldAvarezId')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
    outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT           
			          WHERE  fldAvarezId = @Value


	if (@fieldname=N'fldDesc')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir,
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
   outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
    WHERE  Drd.tblTanzimateDaramad.fldDesc like @Value

	if (@fieldname=N'')
select top(@h) Drd.tblTanzimateDaramad.fldId,  isnull(Drd.tblTanzimateDaramad.fldAvarezId,0)fldAvarezId, isnull(Drd.tblTanzimateDaramad.fldMaliyatId,0)fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                Drd.tblTanzimateDaramad.fldOrganId, isnull(avarez,N'عوارض')  AS fldTitle_CodeAvarez, 
                      isnull(Maliyat,N'مالیات')  AS fldTitle_CodeMaliyat, 
                     tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
				,fldFormul,
				CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez
	from  Drd.tblTanzimateDaramad  INNER JOIN
	/*acc.tblCoding_Details c on c.fldid=fldAvarezId inner join 
	acc.tblCoding_Details c1 on c1.fldid=fldMaliyatId inner join */
	Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
	Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
    Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId inner join 
	Com.tblShomareHesabeOmoomi on Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId inner join 
	Com.tblSHobe on  Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId inner join 
	Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId inner join 
	Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId inner join 
	Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
    Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	outer apply (select title avarez from drd.fn_TitleAvarezAcc('Avarez',@year,@organId)) avarezT
	outer apply (select title maliyat from drd.fn_TitleAvarezAcc('maliyat',@year,@organId)) maliyatT
                      	COMMIT
GO
