SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_PayRptSetting](@organId INT)
AS
SELECT        tblEmployee.fldName, tblEmployee.fldFamily, Com.fn_stringDecode(tblOrganization.fldName) AS OrganName, isnull(tblAshkhaseHoghoghi_Detail.fldAddress,'')fldAddress, tblBank.fldBankName, Pay.tblSetting.fldB_NameShobe, 
                         Com.tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab, Pay.tblSetting.fldB_CodeShenasaee, tblCity.fldName AS CityName, tblState.fldName AS StateName
FROM            Pay.tblSetting INNER JOIN
                         Com.tblOrganization AS tblOrganization ON Pay.tblSetting.fldOrganId = tblOrganization.fldId INNER JOIN
                         Com.tblCity AS tblCity ON tblOrganization.fldCityId = tblCity.fldId INNER JOIN
                         Com.tblState AS tblState ON tblCity.fldStateId = tblState.fldId INNER JOIN
                         Com.tblBank AS tblBank ON Pay.tblSetting.fldB_BankFixId = tblBank.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
					  WHERE fldOrganId=@organId
GO
