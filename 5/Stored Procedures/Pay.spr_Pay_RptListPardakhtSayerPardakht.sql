SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtSayerPardakht](@fieldName NVARCHAR(50),@Sal SMALLINT,@Mah TINYINT,@nobatPardakh TINYINT,@MarhalePardakht TINYINT,@organId INT)
AS
IF(@fieldName='Hoghogh')
SELECT     Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.tblSayerPardakhts.fldAmount, 
                      com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.fn_nobatePardakht(@nobatPardakh) AS NameNobat, @sal AS sal, Com.fn_month(@mah) AS NameMah
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = com.tblShomareHesabOmoomi_Detail.fldShomareHesabId AND 
                      Com.tblShomareHesabeOmoomi.fldId = com.tblShomareHesabOmoomi_Detail.fldShomareHesabId
                      WHERE fldYear=@sal AND fldMonth=@Mah AND fldNobatePardakt=@nobatPardakh AND fldMarhalePardakht=@MarhalePardakht AND Com.tblShomareHesabOmoomi_Detail.fldTypeHesab=0
                      AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId   /*حقوق*/
                      ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
                      
 IF(@fieldName='bon')
 select distinct * from (
SELECT     fldMaliyat,fldKhalesPardakhti,fldAmount, com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId)AS fldName_Family,tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId
,fldShomareHesab,Com.fn_nobatePardakht(@nobatPardakh) AS NameNobat,@sal AS sal ,Com.fn_month(@mah) AS NameMah
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = com.tblShomareHesabOmoomi_Detail.fldShomareHesabId AND 
                      Com.tblShomareHesabeOmoomi.fldId = com.tblShomareHesabOmoomi_Detail.fldShomareHesabId
                      WHERE fldYear=@sal AND fldMonth=@Mah AND fldNobatePardakt=@nobatPardakh AND fldMarhalePardakht=@MarhalePardakht AND fldTypeHesab=1
                       AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId       /*بن کارت*/
                          --ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
						  )t
						   order by fldName_Family
                
GO
