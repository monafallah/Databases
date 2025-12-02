SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKhadamatDarmani](@Sal SMALLINT,@mah TINYINT,@Nobat TINYINT,@organId INT)
as
--declare @Sal SMALLINT=1397,@mah TINYINT=5,@Nobat TINYINT=1,@organId INT=1
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT fldName_Family,fldShomareBime,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldHaghDarman
,fldMashmolBime,fldTedadBime1,fldTedadBime2,fldTedadBime3,fldHaghDarman-(fldHaghDarmanKarfFarma+fldHaghDarmanDolat)as fldMablaghBime,fldPersonalId
 from (select   com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family,   Pay.tblMohasebat_PersonalInfo.fldShomareBime, 
			Pay.tblMohasebat.fldHaghDarmanKarfFarma+isnull( (select sum(fldHaghDarmanKarfFarma) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0) fldHaghDarmanKarfFarma, 
			Pay.tblMohasebat.fldHaghDarmanDolat+isnull((select sum(fldHaghDarmanDolat) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0)fldHaghDarmanDolat, 
                      fldHaghDarman+isnull((select sum(fldHaghDarman) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0) as fldHaghDarman,
					  Pay.tblMohasebat.fldMashmolBime,fldTedadBime1,fldTedadBime2,fldTedadBime3,
					  Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                      AND tblMohasebat_PersonalInfo.fldTypeBimeId=2)t
					  order by fldName_Family
GO
