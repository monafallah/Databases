SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_DisketBimeSum] (@sal SMALLINT ,@mah TINYINT,@KargahBime INT,@nobat TINYINT)
as
--declare @sal SMALLINT=1400,@mah TINYINT=1,@KargahBime INT=1,@nobat TINYINT=1
declare @organ int,@Tarikh varchar(10)=cast(@sal as varchar(4))+'/01/01',@fldWorkShopName nvarchar(200)='',@fldPeyman nvarchar(200),@fldWorkShopNum  nvarchar(200)
select @organ=fldOrganId,@fldWorkShopName=fldWorkShopName, @fldPeyman=fldPeyman,@fldWorkShopNum=fldWorkShopNum from pay.tblInsuranceWorkshop where fldId=@KargahBime
IF(@nobat<>0 and @nobat<=5)
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
select sum(fldItem) as fldItem,sum( fldMashmolBime ) as fldMashmolBime,sum(fldBimePersonal) as fldBimePersonal
,sum(fldBimeKarFarma) as  fldBimeKarFarma,sum(fldBimeBikari) as fldBimeBikari 
,sum(fldBimePersonal)+sum(fldBimeKarFarma)+sum(fldBimeBikari) as fldJBime,@fldWorkShopName + '_' +@fldPeyman as fldWorkShopName
,@fldWorkShopNum + '_' +@fldPeyman as fldWorkShopNum,sum(fldMan) as fldMan,sum(fldWomen) as fldWomen
from (
SELECT 
					  case when fldJensiyat=1 then 1 else 0 end fldMan
					  ,case when fldJensiyat=0 then 1 else 0 end fldWomen
,CASE WHEN fldBimePersonal=0 THEN cast((round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal))as decimal(18,3)) end fldBimePersonal
,CASE WHEN fldBimePersonal=0 THEN cast(fldBimeKarFarma-(round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma))as decimal(18,3))end fldBimeKarFarma
,cast((ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime))as decimal(18,3))fldMashmolBime
,cast((ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldBimeBikari))as decimal(18,3))fldBimeBikari
,cast((ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldItem))as decimal(18,3))fldItem
FROM (SELECT    pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat 
 WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari

,ISNULL((SELECT sum(cast (fldMablagh as bigint))  FROM   Pay.tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1) ,0)
+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma
+ISNULL((SELECT SUM(cast(Pay.tblMoavaghat_Items.fldMablagh  as bigint))+SUM(cast((Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)) as bigint))    FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                      
					  ,isnull(fldJensiyat,cast(0 as bit))fldJensiyat
					  ,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear,fldMonth,fldNobatPardakht
                     ,isnull((select pay.tblKarkardMahane_Detail.fldKargahBimeId from pay.tblKarkardMahane_Detail 
                      where pay.tblKarkardMahane_Detail.fldKarkardMahaneId in(select pay.tblKarKardeMahane.fldId from pay.tblKarKardeMahane where
                       pay.tblKarKardeMahane.fldPersonalId=pay.tblMohasebat.fldPersonalId and pay.tblKarKardeMahane.fldYear=pay.tblMohasebat.fldYear 
                       and pay.tblKarKardeMahane.fldMah=pay.tblMohasebat.fldMonth)and pay.tblKarkardMahane_Detail.fldKargahBimeId=@KargahBime)
					   ,pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId)as kargah
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId  inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
					
  )t where kargah=@KargahBime )t2
   
ELSE if(@nobat=0)
  
  with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
  select sum(fldItem) as fldItem,sum( fldMashmolBime ) as fldMashmolBime,sum(fldBimePersonal) as fldBimePersonal
,sum(fldBimeKarFarma) as  fldBimeKarFarma,sum(fldBimeBikari) as fldBimeBikari 
,sum(fldBimePersonal)+sum(fldBimeKarFarma)+sum(fldBimeBikari) as fldJBime,@fldWorkShopName + '_' +@fldPeyman as fldWorkShopName
,@fldWorkShopNum + '_' +@fldPeyman as fldWorkShopNum,sum(fldMan) as fldMan,sum(fldWomen) as fldWomen
from (
   SELECT fldid,fldAnvaEstekhdamId,fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc
,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldKarkard)fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
					  ,case when fldJensiyat=1 then 1 else 0 end fldMan
					  ,case when fldJensiyat=0 then 1 else 0 end fldWomen
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,case when fldAnvaEstekhdamId=6 then 0 else fldPayeSanavati end fldPayeSanavati,case when fldNoeEstekhdamId=1 then fldTaahol else 0 end fldTaahol,
CASE WHEN fldBimePersonal=0 THEN cast((round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal))as decimal(18,3)) end fldBimePersonal
,CASE WHEN fldBimePersonal=0 THEN cast(fldBimeKarFarma-(round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma))as decimal(18,3))end fldBimeKarFarma
,cast((ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime))as decimal(18,3))fldMashmolBime
,cast((ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldBimeBikari))as decimal(18,3))fldBimeBikari
,cast((ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldItem))as decimal(18,3))fldItem
,cast((ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),abs(KargariMahane)))as decimal(18,3))KargariMahane
,cast((ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),abs(KarmandiMahane)))as decimal(18,3))KarmandiMahane
                      ,fldSh_Personali

FROM (SELECT      tblMohasebat.fldid,pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal,tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat 
 WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((SELECT sum(fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId =2) ,0) as fldPayeSanavati
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=23) ,0) as fldTaahol

,ISNULL((SELECT sum(cast (fldMablagh as bigint))  FROM   Pay.tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1),0)+(Pay.tblMohasebat.fldPasAndaz/2)
+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma+tblMohasebat.fldBimeTakmilyKarFarma
+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat_Items.fldMablagh as bigint))+SUM(cast ((Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)) as bigint) )   FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1),0)
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)=1 and fldMashmolBime>0 then 
							fldMashmolBime-(isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh and m.fldTypeBimeId=1),0))
							-isnull((select sum(m.fldMablagh) from pay.[tblMohasebat_kosorat/MotalebatParam] as m
							inner join pay.tblMotalebateParametri_Personal as p on p.fldId=m.fldMotalebatId
							where m.fldMohasebatId=Pay.tblMohasebat.fldId and p.fldMashmoleBime=1 and p.fldMazayaMashmool=1),0)
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
--					  WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) 
					  ELSE cast(0 as bigint) END  AS KargariMahane
							, CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1  and fldMashmolBime>0 THEN  
							fldMashmolBime-(isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh and m.fldTypeBimeId=1),0))
							-isnull((select sum(m.fldMablagh) from pay.[tblMohasebat_kosorat/MotalebatParam] as m
							inner join pay.tblMotalebateParametri_Personal as p on p.fldId=m.fldMotalebatId
							where m.fldMohasebatId=Pay.tblMohasebat.fldId and p.fldMashmoleBime=1 and p.fldMazayaMashmool=1),0)
							
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
--					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52)
--					  AND fldMohasebatId=Pay.tblMohasebat.fldId),0)
					  ELSE cast(0 as bigint) end AS KarmandiMahane,tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							,(select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId) AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor
					  ,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear,fldMonth,fldNobatPardakht
					  ,isnull((select pay.tblKarkardMahane_Detail.fldKargahBimeId from pay.tblKarkardMahane_Detail 
                      where pay.tblKarkardMahane_Detail.fldKarkardMahaneId in(select pay.tblKarKardeMahane.fldId from pay.tblKarKardeMahane where
                       pay.tblKarKardeMahane.fldPersonalId=pay.tblMohasebat.fldPersonalId and pay.tblKarKardeMahane.fldYear=pay.tblMohasebat.fldYear 
                       and pay.tblKarKardeMahane.fldMah=pay.tblMohasebat.fldMonth)and pay.tblKarkardMahane_Detail.fldKargahBimeId=@KargahBime)
					   ,pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId)as kargah,isnull(fldSh_Personali,'')fldSh_Personali
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId  inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@sal AND fldMonth=@mah  /*AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime */and Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1

  )t where kargah=@KargahBime
  )t

else IF(@nobat=10)
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
select sum(fldItem) as fldItem,sum( fldMashmolBime ) as fldMashmolBime,sum(fldBimePersonal) as fldBimePersonal
,sum(fldBimeKarFarma) as  fldBimeKarFarma,sum(fldBimeBikari) as fldBimeBikari 
,sum(fldBimePersonal)+sum(fldBimeKarFarma)+sum(fldBimeBikari) as fldJBime,@fldWorkShopName + '_' +@fldPeyman as fldWorkShopName
,@fldWorkShopNum + '_' +@fldPeyman as fldWorkShopNum,sum(fldMan) as fldMan,sum(fldWomen) as fldWomen
from (
SELECT fldid,fldAnvaEstekhdamId,fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc
,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldKarkard)fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
					  ,case when fldJensiyat=1 then 1 else 0 end fldMan
					  ,case when fldJensiyat=0 then 1 else 0 end fldWomen
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,case when fldAnvaEstekhdamId=6 then 0 else fldPayeSanavati end fldPayeSanavati,case when fldNoeEstekhdamId=1 then fldTaahol else 0 end fldTaahol,
CASE WHEN fldBimePersonal=0 THEN cast((round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal))as decimal(18,3)) end fldBimePersonal
,CASE WHEN fldBimePersonal=0 THEN cast(fldBimeKarFarma-(round (fldMashmolBime * fldDarsadBimePersonal/100.0,0))as decimal(18,3)) else cast((ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma))as decimal(18,3))end fldBimeKarFarma
,cast((ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime))as decimal(18,3))fldMashmolBime
,cast((ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldBimeBikari))as decimal(18,3))fldBimeBikari
,cast((ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldItem))as decimal(18,3))fldItem
,cast((ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),abs(KargariMahane)))as decimal(18,3))KargariMahane
,cast((ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),abs(KarmandiMahane)))as decimal(18,3))KarmandiMahane
                      ,fldSh_Personali

FROM (SELECT    tblMohasebat.fldid, pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal, tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 cast((ISNULL(Pay.tblMohasebat.fldBimePersonal,0))as bigint) AS fldBimePersonal, 
                      cast(Pay.tblMohasebat.fldBimeKarFarma as bigint) AS fldBimeKarFarma
, cast((ISNULL(Pay.tblMohasebat.fldMashmolBime,0))as bigint) AS fldMashmolBime
,cast((ISNULL(Pay.tblMohasebat.fldBimeBikari,0))as bigint)as fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((SELECT sum(fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId= 2) ,0) as fldPayeSanavati
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=23) ,0) as fldTaahol

,ISNULL((SELECT sum(cast (fldMablagh as bigint))  FROM   Pay.tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1) ,0)
+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma
+tblMohasebat.fldBimeTakmilyKarFarma
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                             ,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)=1 then 
							fldMashmolBime-(isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh and m.fldTypeBimeId=1),0))
							-isnull((select sum(m.fldMablagh) from pay.[tblMohasebat_kosorat/MotalebatParam] as m
							inner join pay.tblMotalebateParametri_Personal as p on p.fldId=m.fldMotalebatId
							where m.fldMohasebatId=Pay.tblMohasebat.fldId and p.fldMashmoleBime=1 and p.fldMazayaMashmool=1),0)
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
--					  WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) 
					  ELSE cast(0 as bigint) END  AS KargariMahane
							, CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
							fldMashmolBime-(isnull((select SUM(cast (i.fldMablagh as bigint)) AS Expr1 FROM  Pay.tblMohasebat_Items as i
							inner join pay.tblMoteghayerhayeHoghoghi_Detail as d on d.fldItemEstekhdamId=i.fldItemEstekhdamId
							inner join pay.tblMoteghayerhayeHoghoghi as m on m.fldId=d.fldMoteghayerhayeHoghoghiId 
							where i.fldMohasebatId=Pay.tblMohasebat.fldId and m.fldAnvaeEstekhdamId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
							and fldMazayaMashmool=1 and m.fldTarikhEjra=@Tarikh and m.fldTypeBimeId=1 ),0))
							-isnull((select sum(m.fldMablagh) from pay.[tblMohasebat_kosorat/MotalebatParam] as m
							inner join pay.tblMotalebateParametri_Personal as p on p.fldId=m.fldMotalebatId
							where m.fldMohasebatId=Pay.tblMohasebat.fldId and p.fldMashmoleBime=1 and p.fldMazayaMashmool=1 ),0)
							
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
--					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52)
--					  AND fldMohasebatId=Pay.tblMohasebat.fldId),0)
					  ELSE cast(0 as bigint) end AS KarmandiMahane,tblMohasebat_PersonalInfo.fldAnvaEstekhdamId
--							,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
--							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
--FROM         Pay.tblMohasebat_Items INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
--					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52)AND fldMohasebatId=Pay.tblMohasebat.fldId),0)
					  --ELSE cast(0 as bigint) end AS KarmandiMahane
							, (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)AS fldNoeEstekhdamId,
                      isnull(fldTarikhTavalod,'')fldTarikhTavalod,isnull(fldMeliyat,cast(0 as bit))fldMeliyat
					  ,isnull(fldJensiyat,cast(0 as bit))fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear,fldMonth,fldNobatPardakht
                      ,isnull(fldSh_Personali,'')fldSh_Personali,isnull((select pay.tblKarkardMahane_Detail.fldKargahBimeId from pay.tblKarkardMahane_Detail 
                      where pay.tblKarkardMahane_Detail.fldKarkardMahaneId in(select pay.tblKarKardeMahane.fldId from pay.tblKarKardeMahane where
                       pay.tblKarKardeMahane.fldPersonalId=pay.tblMohasebat.fldPersonalId and pay.tblKarKardeMahane.fldYear=pay.tblMohasebat.fldYear 
                       and pay.tblKarKardeMahane.fldMah=pay.tblMohasebat.fldMonth)and pay.tblKarkardMahane_Detail.fldKargahBimeId=@KargahBime)
					   ,pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId)as kargah
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId  inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                      WHERE fldYear=@sal AND fldMonth=@mah and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
						
  )t where kargah=@KargahBime)t

 /* update d  set fldMazayaMashmool=1
--select * 
from pay.tblMoteghayerhayeHoghoghi_Detail as d
inner join pay.tblMoteghayerhayeHoghoghi as h on h.fldId=d.fldMoteghayerhayeHoghoghiId
inner join com.tblAnvaEstekhdam as a on a.fldId=h.fldAnvaeEstekhdamId
inner join com.tblItems_Estekhdam as i on i.fldId=d.fldItemEstekhdamId
where fldTarikhEjra='1402/01/01' and a.fldNoeEstekhdamId=1 
and fldItemsHoghughiId not IN  (3,30,31,4,5,2,1,38)
--(1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52) and fldTypeBimeId=1

update pay.tblMotalebateParametri_Personal set fldMazayaMashmool=1
where fldMashmoleBime=1*/
GO
