SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_DisketBimeBASTAM] (@sal SMALLINT ,@mah TINYINT,@KargahBime INT,@nobat TINYINT)
as
declare @organ int
select @organ=fldOrganId from pay.tblInsuranceWorkshop where fldId=@KargahBime
IF(@nobat<>0 and @nobat<=5)
SELECT fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc
,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldKarkard)fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,fldPayeSanavati,case when fldNoeEstekhdamId=1 then fldTaahol else 0 end fldTaahol,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KarmandiMahane)KarmandiMahane
                      ,fldSh_Personali

FROM (SELECT    pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal, tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat 
 WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=3) ,0) as fldPayeSanavati
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=23) ,0) as fldTaahol
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
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
                            ,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)=1 then 
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
							,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52)
					  AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							, (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)AS fldNoeEstekhdamId,
                      isnull(fldTarikhTavalod,'')fldTarikhTavalod,isnull(fldMeliyat,cast(0 as bit))fldMeliyat
					  ,isnull(fldJensiyat,cast(0 as bit))fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor
					  ,Pay.Pay_tblPersonalInfo.fldId AS PersonalId,fldYear,fldMonth,fldNobatPardakht
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
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
						
  )t where kargah=@KargahBime
ELSE if(@nobat=0)
  
  
  
   SELECT fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc
   ,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldKarkard)fldKarkard,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,fldPayeSanavati,case when fldNoeEstekhdamId=1 then fldTaahol else 0 end fldTaahol,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KarmandiMahane)KarmandiMahane

FROM (SELECT     pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal,tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldBimePersonal as bigint)) FROM Pay.tblMoavaghat 
 WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeKarFarma as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldMashmolBime as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)+ISNULL((SELECT     SUM(cast (Pay.tblMoavaghat.fldBimeBikari as bigint))
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=3) ,0) as fldPayeSanavati
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=23) ,0) as fldTaahol
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
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
                            ,CASE WHEN(select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)=1 then 
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
							,CASE WHEN Com.fn_NoEstekhdam(fldAnvaEstekhdamId)<>1 THEN  
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52) AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
							,(select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId) AS fldNoeEstekhdamId,
                      fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS NameSodoor
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
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@sal AND fldMonth=@mah  /*AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime */and Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1

  )t where kargah=@KargahBime
else IF(@nobat=10)
SELECT fldDarsadBimeKarFarma,fldDarsadBimePersonal,fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc
,ISNULL((SELECT     ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldKarkard)fldKarkard
                      ,fldCodemeli,fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,NameSodoor,fldPayeSanavati,case when fldNoeEstekhdamId=1 then fldTaahol else 0 end fldTaahol,
ISNULL((SELECT     (fldBimePersonal*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimePersonal)fldBimePersonal
,ISNULL((SELECT     (fldBimeKarFarma*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldBimeKarFarma)fldBimeKarFarma
,ISNULL((SELECT     (fldMashmolBime*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),fldMashmolBime)fldMashmolBime
,ISNULL((SELECT     (fldBimeBikari*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldBimeBikari)fldBimeBikari
,ISNULL((SELECT     (fldItem*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                     WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					 AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					 and fldKargahBimeId=@KargahBime),fldItem)fldItem
,ISNULL((SELECT     (KargariMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KargariMahane)KargariMahane
,ISNULL((SELECT     (KarmandiMahane*Pay.tblKarkardMahane_Detail.fldKarkard)/Pay.tblKarKardeMahane.fldKarkard
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=PersonalId AND Pay.tblKarKardeMahane.fldYear=t.fldYear 
					  AND Pay.tblKarKardeMahane.fldMah=t.fldmonth AND Pay.tblKarKardeMahane.fldNobatePardakht=t.fldNobatPardakht 
					  and fldKargahBimeId=@KargahBime),KarmandiMahane)KarmandiMahane
                      ,fldSh_Personali

FROM (SELECT    pay.tblMohasebat.fldDarsadBimeKarFarma,pay.tblMohasebat.fldDarsadBimePersonal, tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
 ISNULL(Pay.tblMohasebat.fldBimePersonal,0) AS fldBimePersonal, 
                      Pay.tblMohasebat.fldBimeKarFarma AS fldBimeKarFarma
, ISNULL(Pay.tblMohasebat.fldMashmolBime,0) AS fldMashmolBime
,ISNULL(Pay.tblMohasebat.fldBimeBikari,0)as fldBimeBikari
, Pay.Pay_tblPersonalInfo.fldJobeCode, Pay.tblTabJobOfBime.fldJobDesc
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=3) ,0) as fldPayeSanavati
,ISNULL((SELECT (fldMablagh )  FROM   Pay.tblMohasebat_Items i inner join com.tblItems_Estekhdam as e on e.fldid=i.fldItemEstekhdamId where fldMohasebatId=tblMohasebat.fldid and fldItemsHoghughiId=23) ,0) as fldTaahol
,fldKarkard,tblEmployee.fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam
,ISNULL((SELECT sum(cast (fldMablagh as bigint))  FROM   Pay.tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and tblMohasebat_Items.fldHesabTypeItemId<>1) ,0)
+(Pay.tblMohasebat.fldPasAndaz/2)+tblMohasebat.fldHaghDarmanKarfFarma+tblMohasebat.fldHaghDarmanDolat+tblMohasebat.fldBimeOmrKarFarma
+tblMohasebat.fldBimeTakmilyKarFarma
                      +ISNULL((SELECT    SUM(cast ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint))
                            FROM          [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   Pay.tblMotalebateParametri_Personal ON 
                                                   [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                            WHERE      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId )),0)AS fldItem
                            ,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)=1 then 
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldItemsHoghughiId IN (3,30,31,4,5,2,1,38) AND fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END  AS KargariMahane
							,CASE WHEN (select fldNoeEstekhdamId FROM   Com.tblAnvaEstekhdam WHERE fldid=fldAnvaEstekhdamId)<>1 THEN  
							ISNULL((SELECT     SUM(cast (Pay.tblMohasebat_Items.fldMablagh as bigint)) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldItemsHoghughiId IN (1,2,4,5,6,7,8,9,10,11,19,20,21,36,37,40,41,47,48,49,50,51,52)AND fldMohasebatId=Pay.tblMohasebat.fldId),0)ELSE 0 end AS KarmandiMahane
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
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@sal AND fldMonth=@mah and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organ  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
						
  )t where kargah=@KargahBime
GO
