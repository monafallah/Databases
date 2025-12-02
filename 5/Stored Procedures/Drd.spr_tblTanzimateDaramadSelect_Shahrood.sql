SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTanzimateDaramadSelect_Shahrood] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fiscalyearId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					 ,fldFormul,
					  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	WHERE  tblTanzimateDaramad.fldId = @Value


if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                       ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					     ,fldFormul,  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	WHERE  tblTanzimateDaramad.fldOrganId = @Value



if (@fieldname=N'fldTakhirId')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
								,fldFormul,  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	WHERE  fldTakhirId = @Value


if (@fieldname=N'fldMaliyatId')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                       ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					     ,fldFormul,  CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	WHERE  fldMaliyatId = @Value


if (@fieldname=N'fldAvarezId')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                       ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					,fldFormul,CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                      WHERE  fldAvarezId = @Value


	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                      ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					    ,fldFormul
					    ,CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                     	WHERE  Drd.tblTanzimateDaramad.fldDesc like @Value

	if (@fieldname=N'')
SELECT     TOP (@h) Drd.tblTanzimateDaramad.fldId, Drd.tblTanzimateDaramad.fldAvarezId, Drd.tblTanzimateDaramad.fldMaliyatId, Drd.tblTanzimateDaramad.fldTakhirId, 
                      Drd.tblTanzimateDaramad.fldUserId, Drd.tblTanzimateDaramad.fldDesc, Drd.tblTanzimateDaramad.fldDate, Drd.tblTanzimateDaramad.fldMablaghGerdKardan, 
                      Drd.tblTanzimateDaramad.fldOrganId, Drd.tblCodhayeDaramd.fldDaramadTitle + '(' + Drd.tblCodhayeDaramd.fldDaramadCode + ')' AS fldTitle_CodeAvarez, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS fldTitle_CodeMaliyat, 
                      tblCodhayeDaramd_2.fldDaramadTitle + '(' + tblCodhayeDaramd_2.fldDaramadCode + ')' AS fldTitle_CodeTakhir, 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblTanzimateDaramad.fldNerkh, 
                      Drd.tblTanzimateDaramad.fldChapShenaseGhabz_Pardakht, Drd.tblTanzimateDaramad.fldShorooshenaseGhabz, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldName AS fldNameShobe, Com.tblSHobe.fldCodeSHobe,
                       ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddressOrgan,com.fn_stringDecode(tblOrganization.fldName) AS fldOrganName
					     ,fldFormul
					     ,CASE WHEN fldSumMaliyat_Avarez=1 THEN N'جمع مالیات و عوارض' ELSE N'' END AS fldSumMaliyat_AvarezName,fldSumMaliyat_Avarez

FROM         Drd.tblTanzimateDaramad INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblTanzimateDaramad.fldAvarezId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_1 ON 
                      Drd.tblTanzimateDaramad.fldMaliyatId = tblShomareHesabCodeDaramad_1.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad AS tblShomareHesabCodeDaramad_2 ON 
                      Drd.tblTanzimateDaramad.fldTakhirId = tblShomareHesabCodeDaramad_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_2 ON tblShomareHesabCodeDaramad_2.fldCodeDaramadId = tblCodhayeDaramd_2.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblShomareHesabCodeDaramad_1.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                      Com.tblSHobe INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId ON 
                      Drd.tblTanzimateDaramad.fldShomareHesabIdPishfarz = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblOrganization ON Drd.tblTanzimateDaramad.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId left JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId

                      	COMMIT
GO
