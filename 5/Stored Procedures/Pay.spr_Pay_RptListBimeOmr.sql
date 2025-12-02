SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListBimeOmr](@Year SMALLINT,@month TINYINT,@OrganId int)
AS
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@Year AND fldMonth=@month  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      --AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT    Pay.tblMohasebat.fldId, Com.fn_FamilyEmployee(fldEmployeeId)AS fldName_Family , Prs.Prs_tblPersonalInfo.fldSh_Personali
,Pay.tblMohasebat.fldBimeOmr - Pay.tblMohasebat.fldBimeOmrKarFarma AS fldBimeOmrPersonal,fldBimeOmrKarFarma,Pay.tblMohasebat.fldBimeOmr
 ,Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth,Pay.tblMohasebat.fldYear,tblEmployee.fldCodemeli
FROM         Pay.tblMohasebat INNER JOIN
pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@Year AND fldMonth=@month AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId and Pay.tblMohasebat.fldBimeOmr<>0
                      ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
GO
