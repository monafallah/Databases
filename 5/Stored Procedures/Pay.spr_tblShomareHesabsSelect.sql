SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@value3 NVARCHAR(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
		set @Value= Com.fn_TextNormalize (@Value)
	if (@fieldname=N'fldId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId,	fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
WHERE     (tblShomareHesabeOmoomi.fldId = @Value) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
WHERE     (tblShomareHesabeOmoomi.fldDesc = @Value) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId


	if (@fieldname=N'fldBankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                      WHERE     Com.tblShomareHesabeOmoomi.fldBankId=@Value  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

if (@fieldname=N'CheckBankId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
where     Com.tblShomareHesabeOmoomi.fldBankId=@Value 




if (@fieldname=N'CheckPersonalId')
SELECT TOP (@h)* from (select  Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
				  )t
where    fldPersonalId=@Value 
 
	if (@fieldname=N'fldTypeHesab')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
where fldTypeHesab like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

	if (@fieldname=N'CheckHesab')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
where fldTypeHesab like @Value AND fldShomareHesab=@Value2

if (@fieldname=N'fldPersonalId')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
where Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)like @Value 

if (@fieldname=N'fldShobeId_TypeHesab')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
WHERE tblShomareHesabeOmoomi.fldShobeId like @Value and fldHesabTypeId like @Value2 AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value3


if (@fieldname=N'fldBankId_TypeHesab')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
WHERE tblShomareHesabeOmoomi.fldBankId like @Value and tblShomareHesabOmoomi_Detail.fldTypeHesab like @Value2 
AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value3

if (@fieldname=N'fldBankId_HesabTypeId_PayPerson')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
WHERE tblShomareHesabeOmoomi.fldBankId like @Value and tblShomareHesabOmoomi_Detail.fldHesabTypeId like @Value2 
AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value3

if (@fieldname=N'fldBankId_HesabTypeId')
select  TOP (@h) isnull(Com.tblShomareHesabeOmoomi.fldId,0) as fldId, p.fldId AS fldPersonalId, 
                 isnull( Com.tblSHobe.fldBankId,@Value) AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, isnull(Com.tblShomareHesabeOmoomi.fldUserId,0) as fldUserId, 
                  isnull(Com.tblShomareHesabeOmoomi.fldDate,getdate()) as fldDate, isnull(Com.tblShomareHesabeOmoomi.fldDesc,'')fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, isnull(Com.tblBank.fldBankName,s.fldBankName) as fldBankName ,
				   isnull(Com.tblShomareHesabeOmoomi.fldShobeId,s.fldId) as fldShobeId, isnull(fldHesabTypeId,@Value2)fldHesabTypeId
				  from  Com.tblEmployee INNER JOIN
                  Com.tblAshkhas ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN				  
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId inner join
				  pay.Pay_tblPersonalInfo as p on p.fldPrs_PersonalInfoId=Prs_tblPersonalInfo.fldId	 left JOIN					  
				  Com.tblShomareHesabeOmoomi  inner JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId 
				  and  fldHesabTypeId = @Value2 inner JOIN
             Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId inner JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId and  tblShomareHesabeOmoomi.fldBankId = @Value
				  ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId
				  outer apply(select top 1 b.fldBankName,s.fldName,s.fldId  from com.tblSHobe as s inner join com.tblBank as b on b.fldId=s.fldBankId where fldBankId=@Value order by s.fldid asc)as s
				  WHERE   Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId   AND Com.fn_MaxPersonalStatus( p.fldId ,'hoghoghi')=1
--	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
--                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
--                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
--                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
--                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
--                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
--FROM     Com.tblShomareHesabeOmoomi INNER JOIN
--                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
--                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
--                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
--                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
--                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
--                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
--WHERE tblShomareHesabeOmoomi.fldBankId like @Value and fldHesabTypeId like @Value2 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId


    if (@fieldname=N'fldName_Personal')
			SELECT     TOP (@h)*FROM(SELECT Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                   WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t   WHERE fldName LIKE @Value AND t.fldPersonalId=@value2 
                      
   
    if (@fieldname=N'fldShomareHesab_Personal')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                      WHERE fldShomareHesab LIKE @Value AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value2 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
                      
    if (@fieldname=N'fldShomareKart_Personal')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                       WHERE fldShomareKart LIKE @Value AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value2 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
    if (@fieldname=N'fldSh_Personali_Personal')
				SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                       WHERE fldSh_Personali LIKE @Value AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value2   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  
                       
                                      
    if (@fieldname=N'fldBankName_Personal')
	SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                       WHERE fldBankName LIKE @Value AND Com.fn_PersonalIdwithAshkhasId(fldAshkhasId)=@value2   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                       
                       
                                             
    if (@fieldname=N'fldTypeHesabName_Personal')
			SELECT     TOP (@h)* FROM (SELECT Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                  WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId    )t    WHERE fldTypeHesabName LIKE @Value AND fldPersonalId=@value2                          
                      
   
    if (@fieldname=N'')
				SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
        if (@fieldname=N'ALL')
SELECT TOP (@h) Com.tblShomareHesabeOmoomi.fldId, Com.fn_PersonalIdwithAshkhasId(Com.tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, 
                  Com.tblSHobe.fldBankId AS fldBankFixId, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                  CAST(Com.tblShomareHesabOmoomi_Detail.fldTypeHesab AS nvarchar(1)) AS fldTypeHesab, Com.tblShomareHesabeOmoomi.fldUserId, 
                  Com.tblShomareHesabeOmoomi.fldDate, Com.tblShomareHesabeOmoomi.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName, 
                  CASE WHEN fldTypeHesab = 1 THEN N'بن کارت' ELSE N'حقوق' END AS fldTypeHesabName, Com.tblBank.fldBankName, Com.tblShomareHesabeOmoomi.fldShobeId, fldHesabTypeId
FROM     Com.tblShomareHesabeOmoomi INNER JOIN
                  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                  Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Com.tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId
	COMMIT
GO
