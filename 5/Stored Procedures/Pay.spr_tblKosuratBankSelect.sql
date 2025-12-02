SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosuratBankSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@value2 NVARCHAR(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE  Pay.tblKosuratBank.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE  Pay.tblKosuratBank.fldDesc = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    if (@fieldname=N'ShobeName')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
               where tblSHobe.fldName LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
   
 
    if (@fieldname=N'CheckPersonalId')   
 SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
				where Pay.tblKosuratBank.fldPersonalId=@Value 
				
				
				 
--    if (@fieldname=N'Disket')/*Id بانک باید ثابت باشد بانک شهر*/   
--	begin
--	if(LEN(@value1)<2)
--		set @value1='0'+@value1
-- SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
--                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
--                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
--                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
--                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
--						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
--FROM         Pay.tblKosuratBank INNER JOIN
--                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
--                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
--                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
--                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
--				where 
--				tblSHobe.fldBankId=@value2 AND 
--				SUBSTRING(fldTarikhPardakht,1,4)=@value AND SUBSTRING(fldTarikhPardakht,6,2)=@value1
--				AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
-- end

    if (@fieldname=N'Disket')/*Id بانک باید ثابت باشد بانک شهر*/   
	begin
	if(LEN(@value1)<2)
		set @value1='0'+@value1
 SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe AS tblShobe ON Pay.tblKosuratBank.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
				where 
				tblSHobe.fldBankId=@value2 AND 
				fldYear=@value AND fldMonth=@value1
				AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
 end

    if (@fieldname=N'PersonalId')   
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
				where Pay.tblKosuratBank.fldPersonalId=@Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

	if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId

	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
                      
 	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  Pay.tblKosuratBank.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                      
                      
	if (@fieldname=N'fldPersonalId_BankName')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  fldBankName LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                     
                     	if (@fieldname=N'fldPersonalId_ShobeName')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
	FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  tblSHobe.fldName LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                     
                     
                     	if (@fieldname=N'fldPersonalId_Mablagh')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  fldMablagh = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                     
                     
                     	if (@fieldname=N'fldPersonalId_Count')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  fldCount LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                     
                     
                     	if (@fieldname=N'fldPersonalId_TarikhPardakht')
SELECT     TOP (@h) Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
					,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
	FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      	WHERE Pay.tblKosuratBank.fldPersonalId = @Value1 AND  Pay.tblKosuratBank.fldTarikhPardakht LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                     
                     
                     
                     	if (@fieldname=N'fldPersonalId_StatusName')
SELECT     TOP (@h) * FROM(SELECT Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  ) t
                      	WHERE fldPersonalId = @Value1 AND  fldStatusName LIKE @Value    
                      	
                      	                  
                     	if (@fieldname=N'fldPersonalId_ShomareHesab')
SELECT     TOP (@h) * FROM(SELECT Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  ) t
                      	WHERE fldPersonalId = @Value1 AND  fldShomareHesab LIKE @Value     
           
           IF (@fieldname=N'fldPersonalId_DeactiveDate')
SELECT     TOP (@h) * FROM(SELECT Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  ) t
                      	WHERE fldPersonalId = @Value1 AND  fldDeactiveDate LIKE @Value    
                      	
                      	
                      	           IF (@fieldname=N'fldPersonalId_Desc')
SELECT     TOP (@h) * FROM(SELECT Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate,Pay.tblKosuratBank.fldShomareSheba,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName
						,fldMandeAzGhabl,fldMandeDarFish,tblEmployee.fldName,tblEmployee.fldFamily
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  ) t
                      	WHERE fldPersonalId = @Value1 AND  fldDesc LIKE @Value             
                     
                     
                                                     
                      
                      
                      
	COMMIT
GO
