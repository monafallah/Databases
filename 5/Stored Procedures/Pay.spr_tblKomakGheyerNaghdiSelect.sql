SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKomakGheyerNaghdiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Id INT,
	@PersonalId INT,
	@Year SMALLINT,
	@Month TINYINT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  Pay.tblKomakGheyerNaghdi.fldId = @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  Pay.tblKomakGheyerNaghdi.fldDesc LIKE @Value
	

	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  Pay.tblKomakGheyerNaghdi.fldPersonalId = @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
	
	if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  Pay.tblKomakGheyerNaghdi.fldPersonalId = @Value

		if (@fieldname=N'CheckHasData')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                      WHERE  fldMonth=@Month AND fldYear=@Year AND fldNoeMostamer=@Value

	if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                      WHERE Pay.tblKomakGheyerNaghdi.fldPersonalId=@PersonalId AND fldMonth=@Month AND fldYear=@Year AND fldNoeMostamer=@Value
                      
	if (@fieldname=N'CheckEdit')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                          WHERE Pay.tblKomakGheyerNaghdi.fldId<>@Id AND Pay.tblKomakGheyerNaghdi.fldPersonalId=@PersonalId AND fldMonth=@Month AND fldYear=@Year AND fldNoeMostamer=@Value
                      
 	if (@fieldname=N'CheckPardakht')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                          WHERE  Pay.tblKomakGheyerNaghdi.fldPersonalId=@PersonalId AND fldMonth=@Month AND fldYear=@Year AND fldNoeMostamer=@Value
    and fldFlag=1
   if (@fieldname=N'CheckPardakhtGroup')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                          WHERE   fldMonth=@Month AND fldYear=@Year   AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
						  and fldFlag=1
						  AND fldNoeMostamer=@Value



 	if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId  
                                            
	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  tblKomakGheyerNaghdi.fldPersonalId=@id AND Pay.tblKomakGheyerNaghdi.fldId = @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
 
 if (@fieldname=N'fldPersonalId_Mablagh')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  tblKomakGheyerNaghdi.fldPersonalId=@id AND Pay.tblKomakGheyerNaghdi.fldMablagh LIKE @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
 
 if (@fieldname=N'fldPersonalId_Maliyat')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  tblKomakGheyerNaghdi.fldPersonalId=@id AND Pay.tblKomakGheyerNaghdi.fldMaliyat LIKE @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
 
if (@fieldname=N'fldPersonalId_KhalesPardakhti')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  tblKomakGheyerNaghdi.fldPersonalId=@id AND Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti LIKE @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
 

if (@fieldname=N'fldPersonalId_ShomareHesab')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  tblKomakGheyerNaghdi.fldPersonalId=@id AND fldShomareHesab LIKE @Value AND Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId
 

if (@fieldname=N'fldPersonalId_NameNoeMostamer')
SELECT     TOP (@h)* FROM( select Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                      WHERE  Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId)t
	WHERE fldPersonalId=@id AND fldNameNoeMostamer LIKE @Value 
  




  if (@fieldname=N'fldShomareHesabId')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
				,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
	WHERE  fldShomareHesabId = @Value

 
 	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblKomakGheyerNaghdi.fldId, Pay.tblKomakGheyerNaghdi.fldPersonalId, Pay.tblKomakGheyerNaghdi.fldYear, Pay.tblKomakGheyerNaghdi.fldMonth, 
                      Pay.tblKomakGheyerNaghdi.fldNoeMostamer, Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldUserId, Pay.tblKomakGheyerNaghdi.fldDesc, Pay.tblKomakGheyerNaghdi.fldDate, 
                      CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamer, Pay.tblKomakGheyerNaghdi.fldShomareHesabId, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab,Com.fn_FamilyEmployee(Pay.tblKomakGheyerNaghdi.fldPersonalId) AS fldNameFamilyPersonal,fldFlag
,Com.fn_Month(fldMonth) AS fldMonthName
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblKomakGheyerNaghdi.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId  
                      WHERE  Com.fn_organIdWithPayPersonal(Pay.tblKomakGheyerNaghdi.fldPersonalId)=@OrganId                   

	COMMIT
GO
