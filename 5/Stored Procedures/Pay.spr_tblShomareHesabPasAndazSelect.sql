SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabPasAndazSelect]
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value= Com.fn_TextNormalize (@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  Pay.tblShomareHesabPasAndaz.fldId = @Value AND Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)) =@OrganId
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  Pay.tblShomareHesabPasAndaz.fldDesc LIKE @Value


	if (@fieldname=N'CheckBankId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
				     ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  Com.tblBank.fldId  = @Value 
	
	if (@fieldname=N'fldBankId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
						,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  Com.tblBank.fldId   = @Value AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)) =@OrganId

		if (@fieldname=N'fldAshkhasId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
						,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  Com.tblShomareHesabeOmoomi.fldAshkhasId   = @Value --AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)) =@OrganId
	
	if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
						,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE  (com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) )= @Value
	
	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
	WHERE   com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId) = @Value AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId))  =@OrganId
	
	if (@fieldname=N'fldName')
SELECT     TOP (@h) * FROM (SELECT Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId
                      WHERE   Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)) =@OrganId)t
	WHERE fldName like @Value 
	
		if (@fieldname=N'fldBankName')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 

	WHERE fldBankName like  @Value AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId))  =@OrganId

	if (@fieldname=N'fldBankNameP')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 

	WHERE fldBankName like  @Value and  com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@OrganId --AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId))  =@OrganId


	if (@fieldname=N'fldShomareHesabKarfarma')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 

	WHERE tblShomareHesabeOmoomi.fldShomareHesab like  @Value  and  com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@OrganId --AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId))  =@OrganId

	if (@fieldname=N'fldShomareHesabPersonal')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 

	WHERE tblShomareHesabeOmoomi_1.fldShomareHesab like  @Value and  com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)=@OrganId -- AND  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId))  =@OrganId

	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId,com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
						,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 
                      where  Com.fn_OrganId(com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)) =@OrganId

if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblShomareHesabPasAndaz.fldId, com.fn_PersonalIdwithAshkhasId(tblShomareHesabeOmoomi.fldAshkhasId)  AS fldPersonalId, Com.tblShomareHesabeOmoomi.fldBankId AS fldBankFixId, 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId, Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId, 
                      Pay.tblShomareHesabPasAndaz.fldUserId, Pay.tblShomareHesabPasAndaz.fldDate, Pay.tblShomareHesabPasAndaz.fldDesc, Com.tblBank.fldBankName, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
					,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabPersonal ,tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabKarfarma
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId = tblShomareHesabeOmoomi_1.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblShomareHesabeOmoomi.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId ON Com.tblAshkhas.fldHaghighiId = tblEmployee.fldId 

COMMIT
GO
