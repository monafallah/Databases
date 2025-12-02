SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Pay].[spr_Pay_RptListPardakhtEydi](@CostCenterId int,@Sal SMALLINT,@Mah TINYINT,@NobatPardakht TINYINT,@OrganId int)
as
IF(@CostCenterId<>0)
SELECT   com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,Com.tblEmployee_Detail.fldFatherName,fldShomareHesab,fldKosurat,fldMablagh,fldMaliyat,fldDayCount,fldKhalesPardakhti,Pay.tblMohasebat_Eydi.fldPersonalId  
,Com.fn_nobatePardakht(@NobatPardakht) AS NameNobat,@sal AS Sal
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId
						ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
						
ELSE
SELECT   com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,tblEmployee_Detail.fldFatherName,fldShomareHesab,fldKosurat,fldMablagh,fldMaliyat,fldDayCount,fldKhalesPardakhti,Pay.tblMohasebat_Eydi.fldPersonalId  
,Com.fn_nobatePardakht(@NobatPardakht) AS NameNobat,@sal AS Sal
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                       WHERE fldYear=@Sal AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId
ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
GO
