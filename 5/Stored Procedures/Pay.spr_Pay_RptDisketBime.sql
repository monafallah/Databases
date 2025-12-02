SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptDisketBime](@sal SMALLINT  ,@mah TINYINT,@KargahBime INT,@nobat TINYINT)
AS
declare @Tarikh varchar(10)=cast(@sal as varchar(4))+'01/01'
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
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((select sum(cast (fldmablagh as bigint)) from tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1),0)+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma
+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat_Items.fldMablagh as bigint))+SUM(cast ((Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)) as bigint))    FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)=1 then 
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
					   , fldMashmolBime-(CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
							isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh),0)
					  ELSE cast(0 as bigint) end) AS KarmandiMahane
--							,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)<>1 THEN  
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (19,11,6,4,5,36,1,37,40,41) AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							,
(select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear ,fldMonth,fldNobatPardakht
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId  inner join
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
WHERE fldYear=@sal AND fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
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
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((select sum(cast (fldmablagh as bigint)) from tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1),0)+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma
+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat_Items.fldMablagh as bigint))+SUM(cast ((Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)) as bigint))    FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)=1 then 
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
					  , fldMashmolBime-(CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
							isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh),0)
					  ELSE cast(0 as bigint) end) AS KarmandiMahane
--							,CASE WHEN (select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId)<>1 THEN  
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (19,11,6,4,5,36,1,37,40,41) AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							,
(select fldNoeEstekhdamId from com.tblAnvaEstekhdam where fldId=fldAnvaEstekhdamId) AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear ,fldMonth,fldNobatPardakht
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId  inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                       WHERE fldYear=@sal AND fldMonth=@mah  AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
                      --and fldKarkard<>0
  )t
GO
