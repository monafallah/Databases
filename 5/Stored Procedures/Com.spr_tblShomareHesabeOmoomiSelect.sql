SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Stored Procedure

CREATE PROC [Com].[spr_tblShomareHesabeOmoomiSelect] 
   
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@Value3 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldId = @Value


				if (@fieldname=N'HaveCodeDaramad')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe, Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)



	if (@fieldname=N'fldId_HaveCodeDaramad')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldId = @Value AND Com.tblShomareHesabeOmoomi.fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)
	

		if (@fieldname=N'fldBankName_HaveCodeDaramad')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblBank.fldBankName  like @Value AND Com.tblShomareHesabeOmoomi.fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)

	if (@fieldname=N'fldnameShobe_HaveCodeDaramad')
SELECT top(@h)* from(SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId)as t
	WHERE  nameShobe  like @Value AND fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)
		

		if (@fieldname=N'fldNameAshkhas_HaveCodeDaramad')
SELECT top(@h) * from (SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId) as t
	WHERE  NameAshkhas like @Value AND fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)

if (@fieldname=N'fldShomareHesab_HaveCodeDaramad')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe, CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldShomareHesab = @Value AND Com.tblShomareHesabeOmoomi.fldId IN (SELECT fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@value2)

	
	 
	if (@fieldname=N'fldShobeId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  fldShobeId = @Value

	if (@fieldname=N'fldAshkhasId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  fldAshkhasId = @Value

	if (@fieldname=N'FishId')/*فرق داره*/

	SELECT distinct TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId inner join
				  com.tblAshkhas as a on a.fldId=Com.tblShomareHesabeOmoomi.fldAshkhasId inner join
				  com.tblOrganization as o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId inner join
				  drd.tblSodoorFish as s on s.fldShomareHesabId=tblShomareHesabeOmoomi.fldId inner join
				  Acc.tblCase as c on c.fldSourceId=s.fldId and c.fldCaseTypeId=6 inner join
				  Acc.tblDocumentRecord_Details as d on d.fldCaseId=c.fldId inner join 
				  Acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId inner join 
				  Acc.tblDocumentRecord_Header1 as h1 on h.fldId=h1.fldDocument_HedearId
	WHERE  o.fldId=@Value and h.fldFiscalYearId=@Value2 and tblBank.fldId=@Value3  AND h1.fldModuleSaveId=10

	if (@fieldname=N'OrganId')/*فرق داره*/

	SELECT distinct TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId inner join
				  com.tblAshkhas as a on a.fldId=Com.tblShomareHesabeOmoomi.fldAshkhasId inner join
				  com.tblOrganization as o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId inner join 
				  Acc.tblCase as c on c.fldSourceId=tblShomareHesabeOmoomi.fldId and c.fldCaseTypeId=5 inner join
				  Acc.tblDocumentRecord_Details as d on d.fldCaseId=c.fldId inner join 
				  Acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
	WHERE  o.fldId=@Value and h.fldFiscalYearId=@Value2 and tblBank.fldId=@Value3

	/*union all
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId inner join
				  com.tblAshkhas as a on a.fldId=Com.tblShomareHesabeOmoomi.fldAshkhasId inner join 
				  com.tblEmployee as e on e.fldId=a.fldHaghighiId inner join 
				  prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId

	WHERE  Com.fn_OrganId(p.fldId)=@Value */


		if (@fieldname=N'fldBankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldBankId = @Value


			if (@fieldname=N'fldBankName')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblBank.fldBankName  like @Value

	

		if (@fieldname=N'fldnameShobe')
	SELECT top(@h)* from(SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId)as t
	WHERE  nameShobe like @Value



		if (@fieldname=N'fldNameAshkhas')
	SELECT top(@h) * from (SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId) as t
	WHERE  NameAshkhas like @Value

			
			if (@fieldname=N'fldShomareHesab')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldShomareHesab like @Value

	
	if (@fieldname=N'fldBankName_Ashkhas')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblBank.fldBankName  like @Value and Com.tblShomareHesabeOmoomi.fldAshkhasId like @value2 and Com.tblShomareHesabeOmoomi.fldBankId like @Value3

	if (@fieldname=N'fldnameShobe_Ashkhas')
	SELECT top(@h)* from(SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId)as t
	WHERE  nameShobe like @Value and t.fldAshkhasId like @Value2 and  t.fldBankId like @value3

	if (@fieldname=N'fldShomareHesab_Ashkhas')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldShomareHesab like @Value and Com.tblShomareHesabeOmoomi.fldAshkhasId like @value2 and Com.tblShomareHesabeOmoomi.fldBankId like @Value3

	if (@fieldname=N'fldId_Ashkhas')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldId = @Value and Com.tblShomareHesabeOmoomi.fldAshkhasId like @value2 and Com.tblShomareHesabeOmoomi.fldBankId like @Value3
	 

	if (@fieldname=N'fldNameAshkhas_Ashkhas')
	SELECT top(@h) * from (SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId) as t
	WHERE  NameAshkhas like @Value and t.fldAshkhasId like @Value2 and  t.fldBankId like @value3


	if (@fieldname=N'fldBank_Ashkhas')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldAshkhasId like @value2 and Com.tblShomareHesabeOmoomi.fldBankId like @Value3

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldDesc like @Value

		if (@fieldname=N'fldOrganId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2)


		if (@fieldname=N'fldOrganId_nameShobe')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2) AND Com.tblSHobe.fldName LIKE @Value


		if (@fieldname=N'fldOrganId_NameAshkhas')
SELECT TOP (@h) * FROM (SELECT Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2))t
						 WHERE NameAshkhas LIKE @Value


		if (@fieldname=N'fldOrganId_BankName')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2) AND Com.tblBank.fldBankName LIKE @Value

		if (@fieldname=N'fldOrganId_fldShomareHesab')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2) AND fldShomareHesab LIKE @Value


		if (@fieldname=N'fldOrganId_fldId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2) AND Com.tblShomareHesabeOmoomi.fldId LIKE @Value

if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
				  WHERE fldAshkhasId IN ( SELECT        Com.tblAshkhas.fldId
FROM            Com.tblOrganization INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhas ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhas.fldHoghoghiId
						 WHERE  Com.tblOrganization.fldId =@Value2) AND Com.tblShomareHesabeOmoomi.fldDesc LIKE @Value


	if (@fieldname=N'')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId

-------------------------------------------------------------------------------------------

	if (@fieldname=N'fldId_BankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldId like @Value and Com.tblShomareHesabeOmoomi.fldBankId=@Value3


	if (@fieldname=N'fldShomareHesab_BankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblShomareHesabeOmoomi.fldShomareHesab like @Value  and Com.tblShomareHesabeOmoomi.fldBankId=@Value3



	if (@fieldname=N'fldBankName_BankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE fldBankName like @Value  and Com.tblShomareHesabeOmoomi.fldBankId=@Value3



	if (@fieldname=N'fldNameShobe_BankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE  Com.tblSHobe.fldName like @Value  and Com.tblShomareHesabeOmoomi.fldBankId=@Value3



	if (@fieldname=N'fldNameAshkhas_BankId')
SELECT  TOP (@h) * from (select Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId)t
	WHERE  t.NameAshkhas like @Value  and t.fldBankId=@Value3


		if (@fieldname=N'BankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldAshkhasId, 
                  Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareSheba, Com.tblShomareHesabeOmoomi.fldBankId, 
                  Com.tblShomareHesabeOmoomi.fldUserId, Com.tblShomareHesabeOmoomi.fldDesc, Com.tblShomareHesabeOmoomi.fldDate, Com.tblBank.fldBankName, 
                  Com.tblSHobe.fldName AS nameShobe,CASE WHEN tblShomareHesabeOmoomi.fldDesc <>'' THEN Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId)+'('+ tblShomareHesabeOmoomi.fldDesc+')'  ELSE Com.fn_NameAshkhasHaghighi_Hoghoghi(Com.tblShomareHesabeOmoomi.fldAshkhasId) END AS NameAshkhas, 
                  Com.tblSHobe.fldCodeSHobe
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
	WHERE Com.tblShomareHesabeOmoomi.fldBankId=@Value3



	COMMIT
GO
