SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptSanad3]( @sal SMALLINT,@mah TINYINT,@nobat TINYINT,@organId INT,@CalcType TINYINT=1)
as
--declare  @sal SMALLINT=1404,@mah TINYINT=7,@nobat TINYINT=1,@organId INT=1,@CalcType TINYINT=1
declare @sal1 SMALLINT=1401,@mah1 TINYINT=1,@nobat1 TINYINT=1,@organId1 INT=1
set @sal1=@sal
set @mah1=@mah
set @nobat1=@nobat
set @organId1=@organId
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end
select 
--KolMotalebat+fldMotalebat+hoghogh+ezafekar+karane+tashilatrefahi+SanavatPayanKhedmat+tatilkari+ayelemandi+khoraki+kalaBehdashti+mamoriat
--+bimeKarfarma+darmanKarfarma+omrKarfarma
--+TakmiliKarfarma+pasandazKarfarma,
*
 from (
SELECT DISTINCT  ISNULL(CAST(SUM(KolMotalebat ) OVER (PARTITION BY t.fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId)AS BIGINT),CAST(0 AS BIGINT)) KolMotalebat
,/*case when fldEmploymentCenterId in (3,5) then*/ ISNULL(SUM(CAST(fldMotalebat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)/* else 0 end*/ as fldMotalebat
,ISNULL(SUM(CAST(hoghogh AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)hoghogh
,ISNULL(SUM(CAST(ezafekar AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)ezafekar
,ISNULL(SUM(CAST(karane AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)karane
,ISNULL(SUM(CAST(tashilatrefahi AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)tashilatrefahi
,ISNULL(SUM(CAST(SanavatPayanKhedmat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)SanavatPayanKhedmat
,ISNULL(SUM(CAST(tatilkari AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)tatilkari
,ISNULL(SUM(CAST(ayelemandi AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)ayelemandi
,ISNULL(SUM(CAST(khoraki AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)khoraki
,ISNULL(SUM(CAST(kalaBehdashti AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)kalaBehdashti
,ISNULL(SUM(CAST(Monasebat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)Monasebat
,ISNULL(SUM(CAST(mamoriat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)mamoriat
,ISNULL(SUM(CAST(bimeKarfarma AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)bimeKarfarma
,ISNULL(SUM(CAST(darmanKarfarma AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)darmanKarfarma
,ISNULL(SUM(CAST(omrKarfarma AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)omrKarfarma
,ISNULL(SUM(CAST(TakmiliKarfarma AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)TakmiliKarfarma
,ISNULL(SUM(CAST(pasandazKarfarma AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)pasandazKarfarma
,ISNULL(SUM(CAST(bime AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)bime
,ISNULL(SUM(CAST(maliat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)maliat
,ISNULL(SUM(CAST(pasandaz AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)pasandaz
,ISNULL(SUM(CAST(omr AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)omr
,ISNULL(SUM(CAST(darman AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)darman
,ISNULL(SUM(CAST(takmili AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)takmili
,ISNULL(SUM(CAST(kolkosurat AS bigint)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)kolkosurat
,ISNULL(SUM(CAST(fldkhalesPardakhti AS BIGINT)) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId),0)Khales
,ISNULL(fldEmploymentCenterId,0)fldEmploymentCenterId,
ISNULL(NameTypeCostCenters,0)NameTypeCostCenters,ISNULL(fldTypeBimeId,0)fldTypeBimeId,ISNULL(fldTypeOfCostCenterId,0)fldTypeOfCostCenterId,ISNULL(NameEmploymentCenter,0)NameEmploymentCenter
--,SUM(takmili) OVER (PARTITION BY fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,fldTypeBimeId)takmili
FROM (
select CAST(ISNULL((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
					   WHERE fldMohasebatId=Pay.tblMohasebat.fldId and fldHesabTypeItemId>1 AND fldItemsHoghughiId  NOT IN (1,2,3,4,5,22,23,26,30,31,33,70,34,72,35,71,36,38,25,55,56,65,66,67,73,76)),0)
--+ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
--WHERE  fldMohasebatId=tblMohasebat.fldid AND fldKosoratId IS NULL),0)
+ISNULL((SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and fldHesabTypeItemId>1 AND fldItemsHoghughiId  NOT IN (1,2,5,4,3,30,31,33,70,34,72,26,22,23,35,71,36,38,25,55,56,65,66,67,73) ),0)
                    +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,tblMohasebat.fldHesabTypeId )),0)
		+isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@nobat1 ,tblMohasebat.fldHesabTypeId )),0)
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP  and fldHesabTypeItemId>1 AND fldItemsHoghughiId  NOT IN (1,2,5,4,3,30,31,33,70,34,72,26,22,23,35,71,36,38,25,55,56,65,66,67,73)  ),0) 					
					AS bigint) AS KolMotalebat
					 ,ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=tblMohasebat.fldid AND fldKosoratId IS NULL  and fldHesabTypeParamId>1 ),0) as fldMotalebat
					 ,CAST(( (SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (1,2,5,4,3,30,31,38)  ) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (1,2,5,4,3,30,31,38) ) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (1,2,5,4,3,30,31,38) ),0) 					  
					  AS BIGINT) AS hoghogh
   ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (33,70)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (33,70) ) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN  (33,70) )  ,0) 					  
					  AS BIGINT) AS ezafekar
,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (25,55)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (25,55) ) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (25,55) ),0) 					  
					  AS BIGINT) AS karane
,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (56)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (56) ) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN  (56) ),0) 					  
					  AS BIGINT) AS tashilatrefahi,
CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (36)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (36) ) 
	+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (36) ),0) 				  
					  AS BIGINT) AS SanavatPayanKhedmat,
CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (35,26,71)) +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (35,26,71) ) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (35,26,71) ),0) 					  
					  AS BIGINT) AS tatilkari
     ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (22,23)) 
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (22,23) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (22,23) ),0) 					  
					  AS BIGINT)  AS ayelemandi
     ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (65)) 
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (65) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (65) ),0) 					  
					  AS BIGINT)  AS khoraki
     ,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (66)) 
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (66) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP  and fldHesabTypeItemId>1  AND fldItemsHoghughiId   IN (66) ),0) 					  
					  AS BIGINT)  AS kalaBehdashti
,CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (67)) 
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (67) )
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP  and fldHesabTypeItemId>1  AND fldItemsHoghughiId   IN (67) ),0) 					  
					  AS BIGINT)  AS Monasebat
,
CAST((SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId 
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (34,72)) 
					  +(SELECT     ISNULL(SUM(Pay.tblMoavaghat_Items.fldMablagh), 0) AS Expr1
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId  
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId   and fldHesabTypeItemId>1 AND fldItemsHoghughiId IN (34,72) ) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and fldHesabTypeItemId>1 AND fldItemsHoghughiId   IN (34,72) ),0) 					  
					  AS BIGINT) AS mamoriat
						  ,Pay.tblMohasebat.fldBimeKarFarma + pay.tblMohasebat.fldBimeBikari+ (SELECT ISNULL(SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari),0) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS bimeKarfarma,
						   Pay.tblMohasebat.fldHaghDarmanDolat + Pay.tblMohasebat.fldHaghDarmanKarfFarma+ (SELECT ISNULL(SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat),0) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS darmanKarfarma
						  ,(Pay.tblMohasebat.fldPasAndaz / 2) + (SELECT ISNULL(SUM((Pay.tblMoavaghat.fldPasAndaz/2)),0) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS pasandazKarfarma
						  ,Pay.tblMohasebat.fldBimeOmrKarFarma AS omrKarfarma
						  ,Pay.tblMohasebat.fldBimeTakmilyKarFarma AS TakmiliKarfarma
						  ,Pay.tblMohasebat.fldBimeKarFarma+ (Pay.tblMohasebat.fldBimePersonal) + (Pay.tblMohasebat.fldMogharari+pay.tblMohasebat.fldBimeBikari)+ (SELECT ISNULL(SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeBikari),0)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId)AS bime
						  ,ISNULL(fldmaliyat,0)+ISNULL((select fldMablagh FROM  Pay.tblP_MaliyatManfi WHERE fldMohasebeId=tblMohasebat.fldid),isnull((SELECT  sum(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)) AS maliat
						  ,ISNULL(	Pay.tblMohasebat.fldPasAndaz,0)+isnull((SELECT SUM (Pay.tblMoavaghat.fldPasAndaz)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) AS pasandaz
						   ,(Pay.tblMohasebat.fldBimeOmr) AS omr 
						  ,Pay.tblMohasebat.fldHaghDarman +isnull((select sum(tblMoavaghat.fldHaghDarman) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0) AS darman 
						  ,Pay.tblMohasebat.fldBimeTakmily AS takmili
						  ,
						  CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+
						  ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam] WHERE  fldMohasebatId=tblMohasebat.fldid AND fldMotalebatId IS NULL  and fldHesabTypeParamId>1 ),0)+ isnull((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=tblMohasebat.fldid  ),0)+(fldMosaede)+(fldGhestVam)
						  +isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)
						  AS BIGINT) AS kolkosurat
						 ,fldYear,fldMonth,fldTypeOfCostCenterId,fldEmploymentCenterId,(SELECT Pay.tblTypeOfCostCenters.fldTitle FROM Pay.tblTypeOfCostCenters WHERE fldid=fldTypeOfCostCenterId) AS NameTypeCostCenters
						 ,(SELECT fldTitle FROM Pay.tblTypeOfEmploymentCenter WHERE fldId=fldEmploymentCenterId) AS NameEmploymentCenter,fldTypeBimeId
						 ,/*ISNULL(fldkhalesPardakhti,0)+ISNULL((SELECT SUM(tblMoavaghat.fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) */0AS fldkhalesPardakhti
FROM Pay.tblMohasebat INNER JOIN 
Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId=Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId=Pay.tblCostCenter.fldId 
WHERE fldYear=@sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
--and fldCostCenterId=14
						  
--GROUP BY Pay.tblMohasebat.fldId,fldBimeKarFarma,fldBimeOmrKarFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldHaghDarmanKarfFarma,fldBimePersonal,fldMogharari,fldMaliyat
--,fldBimeOmr,fldHaghDarman,fldBimeTakmily,fldGhestVam,fldYear,fldMonth,fldTypeOfCostCenterId,fldBimeBikari,fldEmploymentCenterId,fldTypeBimeId,fldGhestVam,fldMosaede,fldkhalesPardakhti
	)t
	)t

GO
