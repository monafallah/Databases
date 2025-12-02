SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMandehPasAndazSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMandehPasAndaz.fldId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'fldDesc')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMandehPasAndaz.fldDesc LIKE @Value

	if (@fieldname=N'fldPersonalId')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMandehPasAndaz.fldPersonalId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
		if (@fieldname=N'CheckPersonalId')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMandehPasAndaz.fldPersonalId = @Value 
	
		if (@fieldname=N'ALL')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId


	if (@fieldname=N'')
SELECT   TOP(@h)  Pay.tblMandehPasAndaz.fldId, Pay.tblMandehPasAndaz.fldPersonalId, Pay.tblMandehPasAndaz.FldMablagh, Pay.tblMandehPasAndaz.fldTarikhSabt, 
                      Pay.tblMandehPasAndaz.fldUserID, Pay.tblMandehPasAndaz.fldDesc, Pay.tblMandehPasAndaz.fldDate, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) AS fldName_Father
FROM         Pay.tblMandehPasAndaz INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMandehPasAndaz.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      where Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId

	COMMIT
GO
