SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_DisketBime_Moavaghe] @sal SMALLINT ,@mah TINYINT,@KargahBime INT
as
declare @organ int
select @organ=fldOrganId from pay.tblInsuranceWorkshop where fldId=@KargahBime
;with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=t.fldmonth AND fldNobatePardakht=t.fldNobatPardakht),0)fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=t.fldmonth AND fldNobatePardakht=t.fldNobatPardakht),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=t.fldmonth AND fldNobatePardakht=t.fldNobatPardakht),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=t.fldmonth AND fldNobatePardakht=t.fldNobatPardakht),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldYear AND fldMah=fldmonth AND fldNobatePardakht=t.fldNobatPardakht),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=fldmonth AND fldNobatePardakht=t.fldNobatPardakht),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=fldmonth AND fldNobatePardakht=t.fldNobatPardakht),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=t.fldYear AND fldMah=fldmonth AND fldNobatePardakht=t.fldNobatPardakht),KarmandiMahane)KarmandiMahane
                      ,fldSh_Personali,fldM_Year,fldM_Month

FROM (SELECT     Pay.tblMohasebat.fldDarsadBimeKarFarma, Pay.tblMohasebat.fldDarsadBimePersonal, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName,
 tblMoavaghat_5.fldBimePersonal AS fldBimePersonal, tblMoavaghat_5.fldBimeKarFarma AS fldBimeKarFarma, 
 tblMoavaghat_5.fldMashmolBime AS fldMashmolBime, tblMoavaghat_5.fldBimeBikari AS fldBimeBikari, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc, Pay.tblMohasebat.fldKarkard, 
                      tblEmployee.fldCodemeli, Pay.tblMohasebat_PersonalInfo.fldShomareBime, Com.tblEmployee_Detail.fldSh_Shenasname, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, ISNULL
                          ((SELECT     SUM(Pay.tblMoavaghat_Items.fldMablagh) + SUM((tblMoavaghat_1.fldHaghDarmanKarfFarma + tblMoavaghat_1.fldHaghDarmanDolat) + tblMoavaghat_1.fldPasAndaz / 2) 
                                                    AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1 INNER JOIN
                                                    Pay.tblMoavaghat_Items ON tblMoavaghat_1.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
                              WHERE     (tblMoavaghat_1.fldMohasebatId = Pay.tblMohasebat.fldId)), 0) AS fldItem, 0 AS KargariMahane, 0 AS KarmandiMahane,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldAnvaEstekhdamId)) AS fldNoeEstekhdamId, ISNULL(Com.tblEmployee_Detail.fldTarikhTavalod, '') AS fldTarikhTavalod, 
                      ISNULL(Com.tblEmployee_Detail.fldMeliyat, CAST(0 AS bit)) AS fldMeliyat, ISNULL(Com.tblEmployee_Detail.fldJensiyat, CAST(0 AS bit)) AS fldJensiyat,
                          (SELECT     fldName
                            FROM          Com.tblCity
                            WHERE      (fldId = Com.tblEmployee_Detail.fldMahalSodoorId)) AS NameSodoor, Pay.Pay_tblPersonalInfo.fldId AS PersonalId, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth, 
                      Pay.tblMohasebat.fldNobatPardakht, ISNULL(Prs.Prs_tblPersonalInfo.fldSh_Personali, '') AS fldSh_Personali, tblMoavaghat_5.fldYear AS fldM_Year, tblMoavaghat_5.fldMonth AS fldM_Month
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Pay.tblMoavaghat AS tblMoavaghat_5 ON Pay.tblMohasebat.fldId = tblMoavaghat_5.fldMohasebatId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
WHERE     (Pay.tblMohasebat.fldYear = @sal) AND (Pay.tblMohasebat.fldMonth = @mah) AND (Pay.tblMohasebat_PersonalInfo.fldOrganId = @organ) AND 
                      (Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId = @KargahBime) AND (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1)
						
  )t 
GO
