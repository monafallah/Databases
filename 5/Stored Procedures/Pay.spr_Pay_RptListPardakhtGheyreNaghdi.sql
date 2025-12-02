SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtGheyreNaghdi](@FieldName NVARCHAR(50),@Sal SMALLINT,@mah TINYINT,@organId INT)
as
IF(@FieldName='Mostamar')
SELECT     Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.Pay_tblPersonalInfo.fldId, tblEmployee.fldName, tblEmployee.fldFamily
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNoeMostamer=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
					ORDER BY tblEmployee.fldFamily,tblEmployee.fldName

 IF(@FieldName='GheyreMostamar')
SELECT     Pay.tblKomakGheyerNaghdi.fldMablagh, Pay.tblKomakGheyerNaghdi.fldMaliyat, Pay.tblKomakGheyerNaghdi.fldKhalesPardakhti, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.Pay_tblPersonalInfo.fldId, tblEmployee.fldName, tblEmployee.fldFamily
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNoeMostamer=0   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
GO
