SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptSanad2](@sal SMALLINT ,@mah TINYINT ,@nobat TINYINT,@organId INT,@CalcType TINYINT=1)
as
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end
--DECLARE @sal SMALLINT=1401 ,@mah TINYINT =8,@nobat TINYINT=1,@organId INT=1
SELECT DISTINCT  ISNULL(CAST(SUM(KolMotalebat ) OVER (PARTITION BY t.fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId)AS BIGINT),CAST(0 AS BIGINT)) KolMotalebat
,ISNULL(SUM(CAST(hoghogh AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)hoghogh
,ISNULL(SUM(ezafekar) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)ezafekar
,ISNULL(SUM(ayelemandi) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)ayelemandi
,ISNULL(SUM(mamoriat) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)mamoriat
,ISNULL(SUM(cast(haghbime AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)haghbime
,ISNULL(SUM(cast(bime AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)bime
,ISNULL(SUM(maliat) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)maliat
,ISNULL(SUM(pasandaz) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)pasandaz
,ISNULL(SUM(omr) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)omr
,ISNULL(SUM(darman) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)darman
,ISNULL(SUM (cast(takmili AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)takmili
,ISNULL(SUM(kolkosurat) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)kolkosurat
,ISNULL(SUM(CAST(fldkhalesPardakhti AS BIGINT)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)Khales
,ISNULL(fldEmploymentCenterId,0)fldEmploymentCenterId,
ISNULL(NameTypeCostCenters,0)NameTypeCostCenters,ISNULL(fldTypeBimeId,0)fldTypeBimeId,ISNULL(fldTypeOfCostCenterId,0)fldTypeOfCostCenterId,ISNULL(NameEmploymentCenter,0)NameEmploymentCenter
--,SUM(takmili) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId)takmili
FROM (
SELECT CAST(ISNULL((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId  NOT IN (1,2,3,4,5,22,23,26,30,31,33,34,35,38)),0)
+ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=tblMohasebat.fldid AND fldKosoratId IS NULL),0)
+ISNULL((SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId  NOT IN (1,2,5,4,3,30,31,33,34,26,22,23,35,38) ),0)
 +ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND fldItemsHoghughiId  NOT IN (1,2,5,4,3,30,31,33,34,26,22,23,35,38) ),0)                    
					AS bigint) AS KolMotalebat
,CAST(( (SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (1,2,5,4,3,30,31,38)  ) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (1,2,5,4,3,30,31,38) ) )
 +ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND fldItemsHoghughiId   IN (1,2,5,4,3,30,31,38) ),0)     					  
					  AS BIGINT)
                       
					   AS hoghogh
   ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN  (33,35,26,70,71))
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN  (33,35,26,70,71) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND fldItemsHoghughiId   IN  (33,35,26,70,71) ),0)     					  
					  AS BIGINT) AS ezafekar
 
 ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (22,23)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (22,23) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND fldItemsHoghughiId   IN  (22,23) ),0) 					  
					  AS BIGINT)  AS ayelemandi

, CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (34)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (34,72) ) 
					  +ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND fldItemsHoghughiId   IN  (34,72) ),0) 
					  AS BIGINT) AS mamoriat
						  ,Pay.tblMohasebat.fldBimeKarFarma + Pay.tblMohasebat.fldBimeOmrKarFarma+ Pay.tblMohasebat.fldHaghDarmanDolat + (Pay.tblMohasebat.fldPasAndaz / 2) +pay.tblMohasebat.fldBimeBikari+ Pay.tblMohasebat.fldBimeTakmilyKarFarma + Pay.tblMohasebat.fldHaghDarmanKarfFarma+ (SELECT ISNULL(SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari+(Pay.tblMoavaghat.fldPasAndaz/2)),0) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS haghbime
						  ,Pay.tblMohasebat.fldBimeKarFarma+ (Pay.tblMohasebat.fldBimePersonal) + (Pay.tblMohasebat.fldMogharari+pay.tblMohasebat.fldBimeBikari)+ (SELECT ISNULL(SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeBikari),0)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId)AS bime
						  ,ISNULL(fldmaliyat,0)+ISNULL((select fldMablagh FROM  Pay.tblP_MaliyatManfi WHERE fldMohasebeId=tblMohasebat.fldid),isnull((SELECT  sum(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)) AS maliat
						  ,ISNULL(	Pay.tblMohasebat.fldPasAndaz,0)+isnull((SELECT SUM (Pay.tblMoavaghat.fldPasAndaz)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) AS pasandaz
						   ,(Pay.tblMohasebat.fldBimeOmr) AS omr 
						  ,sum(Pay.tblMohasebat.fldHaghDarman) +isnull((select sum(tblMoavaghat.fldHaghDarman) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0) AS darman 
						  ,Pay.tblMohasebat.fldBimeTakmily AS takmili
						 ,CAST(ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam] WHERE  fldMohasebatId=tblMohasebat.fldid AND fldMotalebatId IS NULL),0)+ isnull((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=tblMohasebat.fldid),0)+(fldMosaede)+(fldGhestVam)AS BIGINT) AS kolkosurat
						 ,fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,(SELECT Pay.tblTypeOfCostCenters.fldTitle FROM Pay.tblTypeOfCostCenters WHERE fldid=fldTypeOfCostCenterId) AS NameTypeCostCenters
						 ,(SELECT fldTitle FROM Pay.tblTypeOfEmploymentCenter WHERE fldId=fldEmploymentCenterId) AS NameEmploymentCenter,fldTypeBimeId
						 ,/*ISNULL(fldkhalesPardakhti,0)+ISNULL((SELECT SUM(tblMoavaghat.fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) */0AS fldkhalesPardakhti
						  FROM Pay.tblMohasebat INNER JOIN 
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId=Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId=Pay.tblCostCenter.fldId
						  WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
						  --and fldCostCenterId=9
						  and fldCalcType=@CalcType
						  GROUP BY Pay.tblMohasebat.fldId, tblMohasebat.fldPersonalId,fldBimeKarFarma,fldBimeOmrKarFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldHaghDarmanKarfFarma,fldBimePersonal,fldMogharari,fldMaliyat
						  ,fldBimeOmr,fldHaghDarman,fldBimeTakmily,fldGhestVam,fldYear,fldMonth,fldTypeOfCostCenterId,fldBimeBikari,fldEmploymentCenterId,fldTypeBimeId,fldGhestVam,fldMosaede,fldkhalesPardakhti
						  
					)t
GO
