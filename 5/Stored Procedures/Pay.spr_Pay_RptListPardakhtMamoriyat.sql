SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtMamoriyat](@Sal SMALLINT,@Mah TINYINT,@organId INT)
AS

SELECT      com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,fldTedadBaBeytute,fldTedadBedunBeytute,fldTashilat+fldMablagh+fldTashilat AS fldmotalebat
,fldBimePersonal,fldMaliyat,fldBimePersonal+fldMaliyat AS fldKosurat,fldKhalesPardakhti,fldShomareHesab,Com.fn_month(@Mah) AS fldMonthName,@Sal AS fldSal,fldMablagh
FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@Sal AND fldMonth =@Mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
order by fldName_Family
GO
