SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtMorakhasi](@Sal SMALLINT,@Mah TINYINT,@CostCenterId INT,@organId INT)
AS
IF(@CostCenterId<>0)
SELECT com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,fldShomareHesab,fldMablagh,fldTedad,fldSalHokm,ISNULL((SELECT ISNULL(SUM(fldMablagh),0) FROM Prs.tblHokm_Item WHERE tblHokm_Item.fldPersonalHokmId=Pay.tblMohasebat_Morakhasi.fldHokmId),0)   AS fldmablaghHokm 
,Com.fn_month(@Mah) AS NameMah,@sal AS fldsal,Pay.tblMohasebat_Morakhasi.fldPersonalId
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
					  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
					  WHERE fldYear=@Sal AND fldMonth=@Mah AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
					ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
ELSE
SELECT com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,fldShomareHesab,fldMablagh,fldTedad,fldSalHokm,ISNULL((SELECT ISNULL(SUM(fldMablagh) ,0)FROM Prs.tblHokm_Item WHERE tblHokm_Item.fldPersonalHokmId=Pay.tblMohasebat_Morakhasi.fldHokmId),0)   AS fldmablaghHokm 
,Com.fn_month(@Mah) AS NameMah,@sal AS fldsal,Pay.tblMohasebat_Morakhasi.fldPersonalId
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
					  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
					  WHERE fldYear=@Sal AND fldMonth=@Mah  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
					  ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
GO
