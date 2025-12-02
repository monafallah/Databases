SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_DisketBimeKhadamatDarmani1](@Sal SMALLINT,@mah TINYINT,@Nobat TINYINT,@organId int)
as
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT     Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldHaghDarman, Pay.tblMohasebat.fldMashmolBime, Prs.tblPersonalHokm.fldTarikhEjra, 
                      Pay.tblMohasebat_PersonalInfo.fldTedadBime1, Pay.tblMohasebat_PersonalInfo.fldTedadBime2, Pay.tblMohasebat_PersonalInfo.fldTedadBime3, 
                      Com.fn_NameFamily(Pay.tblMohasebat.fldPersonalId) AS fldName_Family,
                          (SELECT     fldCodemeli
                            FROM          Com.tblEmployee
                            WHERE      (fldId IN
                                                       (SELECT     fldEmployeeId
                                                         FROM          Prs.Prs_tblPersonalInfo
                                                         WHERE      (fldId IN
                                                                                    (SELECT     fldPrs_PersonalInfoId
                                                                                      FROM          Pay.Pay_tblPersonalInfo
                                                                                      WHERE      (fldId = Pay.tblMohasebat.fldPersonalId)))))) AS fldCodeMeli,
                          (SELECT     fldName
                            FROM          Com.tblEmployee AS tblEmployee_2
                            WHERE      (fldId IN
                                                       (SELECT     fldEmployeeId
                                                         FROM          Prs.Prs_tblPersonalInfo AS Prs_tblPersonalInfo_2
                                                         WHERE      (fldId IN
                                                                                    (SELECT     fldPrs_PersonalInfoId
                                                                                      FROM          Pay.Pay_tblPersonalInfo AS Pay_tblPersonalInfo_2
                                                                                      WHERE      (fldId = Pay.tblMohasebat.fldPersonalId)))))) AS fldName,
                          (SELECT     fldFamily
                            FROM          Com.tblEmployee AS tblEmployee_1
                            WHERE      (fldId IN
                                                       (SELECT     fldEmployeeId
                                                         FROM          Prs.Prs_tblPersonalInfo AS Prs_tblPersonalInfo_1
                                                         WHERE      (fldId IN
                                                                                    (SELECT     fldPrs_PersonalInfoId
                                                                                      FROM          Pay.Pay_tblPersonalInfo AS Pay_tblPersonalInfo_1
                                                                                      WHERE      (fldId = Pay.tblMohasebat.fldPersonalId)))))) AS fldFamily
,isnull((select sum(pay.tblMoavaghat.fldMashmolBime) from pay.tblMoavaghat where fldMohasebatId=Pay.tblMohasebat.fldId),0) as fldMoavaghe
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.tblPersonalHokm ON Prs.tblPersonalHokm.fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId INNER JOIN
                      Pay.Pay_tblPersonalInfo AS Pay_tblPersonalInfo_3 ON Pay.tblMohasebat.fldPersonalId = Pay_tblPersonalInfo_3.fldId AND 
                      Pay.tblMohasebat.fldPersonalId = Pay_tblPersonalInfo_3.fldId AND Pay.tblMohasebat.fldPersonalId = Pay_tblPersonalInfo_3.fldId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=2 AND Com.fn_OrganId(Pay_tblPersonalInfo_3.fldPrs_PersonalInfoId)=@organId
GO
