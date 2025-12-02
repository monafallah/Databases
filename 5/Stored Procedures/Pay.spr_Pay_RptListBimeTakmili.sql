SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListBimeTakmili](@Year SMALLINT,@month TINYINT,@organId INT)
as
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@Year AND fldMonth=@month  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                    --  AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT   distinct  Pay.tblMohasebat.fldYear, Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth,  com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family , Prs.Prs_tblPersonalInfo.fldSh_Personali
	, ISNULL(Pay.tblMohasebat_PersonalInfo.fldT_Asli,0)fldT_Asli, 
                      ISNULL(Pay.tblMohasebat_PersonalInfo.fldT_70,0)fldT_70, ISNULL(Pay.tblMohasebat_PersonalInfo.fldT_60,0)fldT_60,fldBimeTakmilyKarFarma,fldBimeTakmily,
                      tblEmployee.fldCodemeli,Pay.tblMohasebat.fldBimeTakmily - Pay.tblMohasebat.fldBimeTakmilyKarFarma AS fldBimePersonal
                      ,ISNULL(Pay.tblMohasebat_PersonalInfo.fldT_BedonePoshesh,0)fldT_BedonePoshesh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@Year AND fldMonth=@month AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and Pay.tblMohasebat.fldBimeTakmily<>0
					 
                      ORDER BY fldName_Family
GO
