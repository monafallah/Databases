SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseHoghogh](@fieldname NVARCHAR(50), @sal SMALLINT,@mah TINYINT,@nobat TINYINT,@OrganId INT,@Tasal SMALLINT,@Tamah TINYINT,
@CalcType TINYINT=1)
as
declare @fieldname1 NVARCHAR(50), @sal1 SMALLINT,@mah1 TINYINT,@nobat1 TINYINT,@OrganId1 INT,@Tasal1 SMALLINT,@Tamah1 TINYINT
set @fieldname1=@fieldname
set @sal1=@sal
set @mah1=@mah
set @nobat1=@nobat
set @OrganId1=@OrganId
set @Tasal1=@Tasal
set @Tamah1=@Tamah
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINT
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end

IF(@fieldname1='CostCenter')
SELECT DISTINCT CAST(SUM(jamMotalebat) OVER(PARTITION BY t.fldCostCenterId) AS BIGINT) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldCostCenterId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldCostCenterId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldCostCenterId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldCostCenterId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldCostCenterId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldCostCenterId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldCostCenterId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldCostCenterId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldCostCenterId)fldMosaede
,CAST(SUM(KolKosurat)OVER(PARTITION BY t.fldCostCenterId) AS BIGINT)KolKosurat,count(tedad)OVER(PARTITION BY t.fldCostCenterId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                    CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)
					+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId>1) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)
						  +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						 +sum(ISNULL(fldMablaghMotamam,0))
						  AS BIGINT) AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblCostCenter.fldTitle,
                              cast(ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))as bigint) maliyat
						,cast(SUM(fldHaghDarman)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as bigint)AS HaghDarman
						,cast(CASE WHEN fldTypeBimeId=1 THEN sum (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) ELSE 0 END as bigint) AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN cast(SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as bigint) ELSE 0 END  AS Bazneshastegi
						,fldBimeOmr, cast(fldBimeTakmily as bigint)as fldBimeTakmily
						,SUM(fldPasAndaz)+ISNULL((SELECT sum(Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldPasAndaz
						,cast(fldGhestVam as bigint)fldGhestVam,cast(fldMosaede as bigint)fldMosaede
						, 
						CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+
						(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)

						AS bigint) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
					   outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId<>1
                                group by m2.fldPersonalId )motamam
WHERE fldYear=@sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1-- and fldCostCenterId=10
and tblMohasebat.fldHesabTypeId>1 and fldCalcType=@CalcType
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId, Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblMohasebat.fldId, Pay.tblCostCenter.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldBankId,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t

IF(@fieldname1='CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah1)=1 THEN cast(CAST(@sal1 AS NVARCHAR(4))+'0'+CAST(@mah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal1 AS NVARCHAR(4))+CAST(@mah1 AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(2))AS bigint) end    
SELECT cast(SUM(jamMotalebat) as bigint)jamMotalebat,fldTitle,sum(maliyat)maliyat,SUM(HaghDarman)HaghDarman,SUM(TaminEjtemaee)TaminEjtemaee
,SUM(Bazneshastegi)Bazneshastegi,SUM(fldBimeOmr)fldBimeOmr,SUM(fldBimeTakmily)fldBimeTakmily,SUM(fldPasAndaz)fldPasAndaz,
SUM(fldGhestVam)fldGhestVam,SUM(fldMosaede)fldMosaede,cast(SUM(KolKosurat) as bigint)KolKosurat,SUM(tedad)tedad
FROM(
SELECT DISTINCT CAST(SUM(jamMotalebat) OVER(PARTITION BY t.fldCostCenterId) AS BIGINT) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldCostCenterId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldCostCenterId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldCostCenterId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldCostCenterId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldCostCenterId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldCostCenterId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldCostCenterId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldCostCenterId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldCostCenterId)fldMosaede
,CAST(SUM(KolKosurat)OVER(PARTITION BY t.fldCostCenterId) AS BIGINT)KolKosurat,count(tedad)OVER(PARTITION BY t.fldCostCenterId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                    CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId>1) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)	
						  +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						   +sum(ISNULL(fldMablaghMotamam,0))
						   AS BIGINT) AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblCostCenter.fldTitle,
                              cast(ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))as bigint) maliyat
						,cast(SUM(fldHaghDarman)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as bigint)AS HaghDarman
						,cast(CASE WHEN fldTypeBimeId=1 THEN sum (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) ELSE 0 END as bigint) AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN cast(SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as bigint) ELSE 0 END  AS Bazneshastegi
						,fldBimeOmr, cast(fldBimeTakmily as bigint)as fldBimeTakmily
						,SUM(fldPasAndaz)+ISNULL((SELECT sum(Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldPasAndaz
						,cast(fldGhestVam as bigint)fldGhestVam,cast(fldMosaede as bigint)fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						
						AS bigint) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
					  outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId 
								and CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
								--and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								and o.fldHesabTypeItemId<>1
                                group by m2.fldPersonalId )motamam
WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1 and fldCalcType=@CalcType and tblMohasebat.fldHesabTypeId>1 -- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId, Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblMohasebat.fldId, Pay.tblCostCenter.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t
)s
GROUP BY fldTitle

END

IF(@fieldname1='ChartOrgan')
SELECT DISTINCT cast(SUM(jamMotalebat) OVER(PARTITION BY t.fldChartOrganId)as bigint) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldChartOrganId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldChartOrganId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldChartOrganId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldChartOrganId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldChartOrganId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldChartOrganId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldChartOrganId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldChartOrganId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldChartOrganId)fldMosaede
,cast(SUM(KolKosurat)OVER(PARTITION BY t.fldChartOrganId) as bigint)KolKosurat,COUNT(tedad)OVER(PARTITION BY t.fldChartOrganId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                  CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)++ISNULL((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId>1) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)
						   +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+sum(ISNULL(fldMablaghMotamam,0))
						  AS BIGINT)	 AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,
                              (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) maliyat
						,SUM(fldHaghDarman)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS HaghDarman
						,CASE WHEN fldTypeBimeId=1 THEN SUM (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) ELSE 0 END AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END AS Bazneshastegi
						,fldBimeOmr, fldBimeTakmily
						,SUM(fldPasAndaz)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldPasAndaz
						,fldGhestVam,fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT SUM(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)

						AS BIGINT) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
					  outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId 
								and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								and o.fldHesabTypeItemId<>1
                                group by m2.fldPersonalId )motamam
WHERE fldYear=@sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1 
and fldCalcType=@CalcType-- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Pay.tblMohasebat.fldId,Com.tblChartOrganEjraee.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t


IF(@fieldname1='ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah1)=1 THEN CAST(CAST(@sal1 AS NVARCHAR(4))+'0'+CAST(@mah1 AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(@sal1 AS NVARCHAR(4))+CAST(@mah1 AS NVARCHAR(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(2))AS bigint) end    
SELECT cast(SUM(jamMotalebat)as bigint)jamMotalebat,fldTitle,sum(maliyat)maliyat,SUM(HaghDarman)HaghDarman,SUM(TaminEjtemaee)TaminEjtemaee
,SUM(Bazneshastegi)Bazneshastegi,SUM(fldBimeOmr)fldBimeOmr,SUM(fldBimeTakmily)fldBimeTakmily,SUM(fldPasAndaz)fldPasAndaz,
SUM(fldGhestVam)fldGhestVam,SUM(fldMosaede)fldMosaede,cast(SUM(KolKosurat) as bigint)KolKosurat,SUM(tedad)tedad
FROM(
SELECT DISTINCT cast(SUM(jamMotalebat) OVER(PARTITION BY t.fldChartOrganId)as bigint) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldChartOrganId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldChartOrganId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldChartOrganId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldChartOrganId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldChartOrganId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldChartOrganId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldChartOrganId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldChartOrganId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldChartOrganId)fldMosaede
,cast(SUM(KolKosurat)OVER(PARTITION BY t.fldChartOrganId) as bigint)KolKosurat,COUNT(tedad)OVER(PARTITION BY t.fldChartOrganId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                  CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)++ISNULL((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId>1) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0) 
						  +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						  +sum(ISNULL(fldMablaghMotamam,0))
AS BIGINT)	 AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,
                              (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) maliyat
						,SUM(fldHaghDarman)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS HaghDarman
						,CASE WHEN fldTypeBimeId=1 THEN SUM (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari)  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) ELSE 0 END AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal+Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldBimeBikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ELSE 0 END AS Bazneshastegi
						,fldBimeOmr, fldBimeTakmily
						,SUM(fldPasAndaz)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)fldPasAndaz
						,fldGhestVam,fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT SUM(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)

						AS BIGINT) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
					  outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId 
								and CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
								--and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								and o.fldHesabTypeItemId<>1
                                group by m2.fldPersonalId )motamam
WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1 and fldCalcType=@CalcType-- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Pay.tblMohasebat.fldId,Com.tblChartOrganEjraee.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t
)s
	group by fldTitle
end  
IF(@fieldname1='CostCenter_BedoneMoavaghe')
SELECT DISTINCT CAST(SUM(jamMotalebat) OVER(PARTITION BY t.fldCostCenterId) AS BIGINT) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldCostCenterId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldCostCenterId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldCostCenterId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldCostCenterId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldCostCenterId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldCostCenterId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldCostCenterId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldCostCenterId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldCostCenterId)fldMosaede
,CAST(SUM(KolKosurat)OVER(PARTITION BY t.fldCostCenterId) AS BIGINT)KolKosurat,count(tedad)OVER(PARTITION BY t.fldCostCenterId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                    CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)+
					+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)
					+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari	
					 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
AS BIGINT) AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblCostCenter.fldTitle,
                              cast(ISNULL(Pay.tblMohasebat.fldMaliyat,0)as bigint) maliyat
						,cast(SUM(fldHaghDarman)as bigint)AS HaghDarman
						,cast(CASE WHEN fldTypeBimeId=1 THEN sum (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)
						 ELSE 0 END as bigint) AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN cast(SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)as bigint) ELSE 0 END  AS Bazneshastegi
						,fldBimeOmr, cast(fldBimeTakmily as bigint)as fldBimeTakmily
						,SUM(fldPasAndaz)fldPasAndaz
						,cast(fldGhestVam as bigint)fldGhestVam,cast(fldMosaede as bigint)fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)
	+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)
				
					AS bigint) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE fldYear=@sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1
 and fldCalcType=@CalcType-- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblMohasebat.fldId, Pay.tblCostCenter.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t

IF(@fieldname1='CostCenter_Sal_BedoneMoavaghe')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah1)=1 THEN cast(CAST(@sal1 AS NVARCHAR(4))+'0'+CAST(@mah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal1 AS NVARCHAR(4))+CAST(@mah1 AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(2))AS bigint) end    
SELECT cast(SUM(jamMotalebat) as bigint)jamMotalebat,fldTitle,sum(maliyat)maliyat,SUM(HaghDarman)HaghDarman,SUM(TaminEjtemaee)TaminEjtemaee
,SUM(Bazneshastegi)Bazneshastegi,SUM(fldBimeOmr)fldBimeOmr,SUM(fldBimeTakmily)fldBimeTakmily,SUM(fldPasAndaz)fldPasAndaz,
SUM(fldGhestVam)fldGhestVam,SUM(fldMosaede)fldMosaede,cast(SUM(KolKosurat) as bigint)KolKosurat,SUM(tedad)tedad
FROM(
SELECT DISTINCT CAST(SUM(jamMotalebat) OVER(PARTITION BY t.fldCostCenterId) AS BIGINT) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldCostCenterId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldCostCenterId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldCostCenterId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldCostCenterId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldCostCenterId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldCostCenterId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldCostCenterId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldCostCenterId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldCostCenterId)fldMosaede
,CAST(SUM(KolKosurat)OVER(PARTITION BY t.fldCostCenterId) AS BIGINT)KolKosurat,count(tedad)OVER(PARTITION BY t.fldCostCenterId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                    CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)+
					+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)
					+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari	
					 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
					AS BIGINT) AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblCostCenter.fldTitle,
                              cast(ISNULL(Pay.tblMohasebat.fldMaliyat,0)as bigint) maliyat
						,cast(SUM(fldHaghDarman)as bigint)AS HaghDarman
						,cast(CASE WHEN fldTypeBimeId=1 THEN sum (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)
						 ELSE 0 END as bigint) AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN cast(SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)as bigint) ELSE 0 END  AS Bazneshastegi
						,fldBimeOmr, cast(fldBimeTakmily as bigint)as fldBimeTakmily
						,SUM(fldPasAndaz)fldPasAndaz
						,cast(fldGhestVam as bigint)fldGhestVam,cast(fldMosaede as bigint)fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)
	+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)
					
						AS bigint) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1
  and fldCalcType=@CalcType-- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldCostCenterId, Pay.tblMohasebat.fldId, Pay.tblCostCenter.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t
)s
GROUP BY fldTitle

END

IF(@fieldname1='ChartOrgan_BedoneMoavaghe')
SELECT DISTINCT cast(SUM(jamMotalebat) OVER(PARTITION BY t.fldChartOrganId)as bigint) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldChartOrganId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldChartOrganId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldChartOrganId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldChartOrganId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldChartOrganId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldChartOrganId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldChartOrganId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldChartOrganId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldChartOrganId)fldMosaede
,cast(SUM(KolKosurat)OVER(PARTITION BY t.fldChartOrganId) as bigint)KolKosurat,COUNT(tedad)OVER(PARTITION BY t.fldChartOrganId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                  CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)+
				  +ISNULL((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)
				  +fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari
						 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
AS BIGINT)	 AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,
                              (ISNULL(Pay.tblMohasebat.fldMaliyat,0)) maliyat
						,SUM(fldHaghDarman)AS HaghDarman
						,CASE WHEN fldTypeBimeId=1 THEN SUM (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)
						 ELSE 0 END AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)
 ELSE 0 END AS Bazneshastegi
						,fldBimeOmr, fldBimeTakmily
						,SUM(fldPasAndaz) fldPasAndaz
						,fldGhestVam,fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)
 +isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)

 AS BIGINT) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
WHERE fldYear=@sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1
 and fldCalcType=@CalcType -- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Pay.tblMohasebat.fldId,Com.tblChartOrganEjraee.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t


IF(@fieldname1='ChartOrgan_Sal_BedoneMoavaghe')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah1)=1 THEN CAST(CAST(@sal1 AS NVARCHAR(4))+'0'+CAST(@mah1 AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(@sal1 AS NVARCHAR(4))+CAST(@mah1 AS NVARCHAR(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(2))AS bigint) end    
SELECT cast(SUM(jamMotalebat)as bigint)jamMotalebat,fldTitle,sum(maliyat)maliyat,SUM(HaghDarman)HaghDarman,SUM(TaminEjtemaee)TaminEjtemaee
,SUM(Bazneshastegi)Bazneshastegi,SUM(fldBimeOmr)fldBimeOmr,SUM(fldBimeTakmily)fldBimeTakmily,SUM(fldPasAndaz)fldPasAndaz,
SUM(fldGhestVam)fldGhestVam,SUM(fldMosaede)fldMosaede,cast(SUM(KolKosurat) as bigint)KolKosurat,SUM(tedad)tedad
FROM(
SELECT DISTINCT cast(SUM(jamMotalebat) OVER(PARTITION BY t.fldChartOrganId)as bigint) AS jamMotalebat,fldTitle,SUM(t.maliyat)OVER(PARTITION BY t.fldChartOrganId) maliyat,SUM(HaghDarman)OVER(PARTITION BY t.fldChartOrganId)HaghDarman,SUM(CAST(TaminEjtemaee AS BIGINT))OVER(PARTITION BY t.fldChartOrganId)TaminEjtemaee
,SUM(Bazneshastegi)OVER(PARTITION BY t.fldChartOrganId)Bazneshastegi ,SUM(fldBimeOmr)OVER(PARTITION BY t.fldChartOrganId)fldBimeOmr
,SUM(fldBimeTakmily)OVER(PARTITION BY t.fldChartOrganId)fldBimeTakmily,SUM(fldPasAndaz)OVER(PARTITION BY t.fldChartOrganId)fldPasAndaz
,SUM(fldGhestVam)OVER(PARTITION BY t.fldChartOrganId)fldGhestVam,SUM(fldMosaede)OVER(PARTITION BY t.fldChartOrganId)fldMosaede
,cast(SUM(KolKosurat)OVER(PARTITION BY t.fldChartOrganId) as bigint)KolKosurat,COUNT(tedad)OVER(PARTITION BY t.fldChartOrganId)tedad
FROM  
(
SELECT  COUNT (Pay.tblMohasebat.fldid) tedad,
                  CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId<>76),0)+
				  +ISNULL((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1),0)
				  +fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari
						 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
AS BIGINT)	 AS jamMotalebat
                              , Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,
                              (ISNULL(Pay.tblMohasebat.fldMaliyat,0)) maliyat
						,SUM(fldHaghDarman)AS HaghDarman
						,CASE WHEN fldTypeBimeId=1 THEN SUM (fldBimePersonal+fldBimeKarFarma+fldBimeBikari)
						 ELSE 0 END AS TaminEjtemaee
						
,CASE WHEN fldTypeBimeId=2 THEN SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)
 ELSE 0 END AS Bazneshastegi
						,fldBimeOmr, fldBimeTakmily
						,SUM(fldPasAndaz) fldPasAndaz
						,fldGhestVam,fldMosaede
						,CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1),0)+ISNULL((SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)
 +isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal ,@Mah,@Nobat ,fldHesabTypeId,fldBankId )),0)
AS BIGINT) AS KolKosurat 
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId1
  and fldCalcType=@CalcType-- and fldCostCenterId=10
GROUP BY fldPersonalId,tblMohasebat.fldHesabTypeId,fldBankId, Pay.tblMohasebat_PersonalInfo.fldChartOrganId, Pay.tblMohasebat.fldId,Com.tblChartOrganEjraee.fldTitle,fldTypeBimeId,fldBimeOmr
,fldBimeTakmily,fldGhestVam,fldMosaede,fldHaghDarmanKarfFarma,fldHaghDarmanDolat,fldPasAndaz,fldBimeTakmilyKarFarma,fldBimeOmrKarFarma,fldBimePersonal,fldMaliyat,fldHaghDarman,fldBimeKarFarma,fldBimeBikari,fldMogharari
)t
)s
	group by fldTitle
end  
GO
