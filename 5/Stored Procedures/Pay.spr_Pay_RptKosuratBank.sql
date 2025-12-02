SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKosuratBank](@NobatePardakht tinyint,@Year SMALLINT,@Month TINYINT,@costcenterId INT,@organId INT,
@CalcType TINYINT=1 )
AS
IF(@costcenterId<>0)
SELECT  * FROM (SELECT  tblKosuratBank.fldId, tblBank.fldBankName + N' شعبه ' + tblShobe.fldName AS fldNameBank, SUM(Pay.tblMohasebat_KosoratBank.fldMablagh) AS fldMablagh, tblShobe.fldId AS fldShobeId, 
                      Pay.tblMohasebat.fldYear, Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth, Pay.tblKosuratBank.fldShomareHesab, tblEmployee.fldName, 
                      tblEmployee.fldFamily, tblBank.fldId AS fldBankId,   Pay.tblKosuratBank.fldDesc,fldFatherName
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe AS tblShobe ON Pay.tblKosuratBank.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE fldNobatPardakht=@NobatePardakht AND fldYear=@Year AND fldMonth=@Month AND fldCostCenterId=@costcenterId AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
                     	and fldCalcType=@CalcType
					  GROUP BY tblKosuratBank.fldId,  tblSHobe.fldId,tblBank.fldBankName, tblSHobe.fldName,fldYear,fldMonth,fldShomareHesab,tblEmployee.fldName,tblEmployee.fldFamily,tblBank.fldId,  Pay.tblKosuratBank.fldDesc,fldFatherName)t
					  ORDER by fldFamily
					  

ELSE 
SELECT * FROM (SELECT tblKosuratBank.fldId,    tblBank.fldBankName + N' شعبه ' + tblShobe.fldName AS fldNameBank, SUM(Pay.tblMohasebat_KosoratBank.fldMablagh) AS fldMablagh, tblShobe.fldId AS fldShobeId, 
                      Pay.tblMohasebat.fldYear, Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth, Pay.tblKosuratBank.fldShomareHesab, tblEmployee.fldName, 
                      tblEmployee.fldFamily, tblBank.fldId AS fldBankId,   Pay.tblKosuratBank.fldDesc, fldFatherName
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe AS tblShobe ON Pay.tblKosuratBank.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldNobatPardakht=@NobatePardakht AND fldYear=@Year AND fldMonth=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
                      	and fldCalcType=@CalcType
					  GROUP BY tblKosuratBank.fldId,  tblSHobe.fldId,tblBank.fldBankName, tblSHobe.fldName,fldYear,fldMonth,fldShomareHesab,tblEmployee.fldName,tblEmployee.fldFamily,tblBank.fldId,  Pay.tblKosuratBank.fldDesc,fldFatherName)t
					    ORDER by fldFamily
GO
