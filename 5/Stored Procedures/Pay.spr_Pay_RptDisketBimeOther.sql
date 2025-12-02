SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptDisketBimeOther](@sal SMALLINT  ,@mah TINYINT,@KargahBime INT,@nobat TINYINT)
AS
IF(@nobat<>0)
 with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,(Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht))fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId,case when Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht)=0 then 0 else (KargariMahane+KarmandiMahane)/(Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht)) end as Rozane
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),KarmandiMahane)KarmandiMahane

FROM (SELECT     tblEmployee.fldName, fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldBimeKarFarma)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldMashmolBime)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldBimeBikari)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((select sum(fldmablagh) from tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1),0)+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma+ISNULL((SELECT SUM(Pay.tblMoavaghat_Items.fldMablagh)+SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2))    FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh)
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)=1 then ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
							,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)<>1 THEN  ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (19,11,6,4,5,36,1,37,40,41) AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							,
(select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear ,fldMonth,fldNobatPardakht
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
                      --and fldKarkard<>0/*این شرط برای اینکه error  تقسیم بر صفر میده*/
  )t 
   ELSE
  
   with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah and Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
  
  SELECT fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,(Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht))fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId,case when (Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht))=0 then 0 else  (KargariMahane+KarmandiMahane)/(Com.fn_KarKard(fldNoeEstekhdamId,PersonalId,fldyear,fldmonth,fldNobatPardakht))end as Rozane
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND fldYear=fldyear AND fldMah=fldmonth AND fldNobatePardakht=fldNobatPardakht),KarmandiMahane)KarmandiMahane

FROM (SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldBimeKarFarma)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldMashmolBime)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(Pay.tblMoavaghat.fldBimeBikari)
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((select sum(fldmablagh) from tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1),0)+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma+ISNULL((SELECT SUM(Pay.tblMoavaghat_Items.fldMablagh)+SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2))    FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh)
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)=1 then ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
							,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)<>1 THEN  ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (19,11,6,4,5,36,1,37,40,41) AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							,
(select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId) AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear ,fldMonth,fldNobatPardakht
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                       WHERE fldYear=@sal AND fldMonth=@mah  AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
                      --and fldKarkard<>0
  )t
GO
