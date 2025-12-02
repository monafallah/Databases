SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseBonKart](@fieldName NVARCHAR(50),@Sal SMALLINT,@Mah TINYINT,@Nobat TINYINT,@organId INT,@Tasal SMALLINT,@Tamah TINYINT,
@CalcType TINYINT=1)
AS

--declare @fieldName NVARCHAR(50)='CostCenter',@Sal SMALLINT=1404,@Mah TINYINT=7,@Nobat TINYINT=1,@organId INT=1,@Tasal SMALLINT,@Tamah TINYINT,@CalcType TINYINT=1
--@CalcType TINYINT=1
declare @fieldName1 NVARCHAR(50)='CostCenter',@Sal1 SMALLINT=1403,@Mah1 TINYINT=2,@Nobat1 TINYINT=1,@marhale1 TINYINT=1,@organId1 INT=1,@Tasal1 SMALLINT,@Tamah1 TINYINT
set @fieldName1=@fieldName
set @Sal1=@Sal
set @Mah1=@Mah
set @Nobat1=@Nobat
set @organId1=@organId
set @Tasal1=@Tasal
set @Tamah1=@Tamah
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINt
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end

IF(@fieldName1='CostCenter')
SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(m.fldId)  OVER (PARTITION BY tblMohasebat_PersonalInfo.fldCostCenterId) AS fldTedad
, ((isnull(item.fldMablagh,0)+isnull(mo.fldMablagh,0) +isnull(o.fldMablaghMoavagh,0)+isnull(motamam.fldMablaghMotamam,0)
)
+isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,1 )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
)-(isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
						
)
as fldMablagh

FROM         Pay.tblMohasebat as m INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
					  outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMohasebat_Items as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)item
					   outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeParamId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)mo
					 outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablaghMoavagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMoavaghat as o on o.fldMohasebatId=m2.fldId inner join
									pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)o
					  outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId=1
								and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId
                                 )motamam
                      WHERE fldYear=@Sal1 AND fldMonth=@Mah1 AND m.fldNobatPardakht=@Nobat1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
					  and (item.fldMablagh>=0 or mo.fldMablagh>=0) and fldCalcType=@CalcType

IF(@fieldName1='CostCenter_Sal')
BEGIN
SET @Tarikh1=@Sal1*100+@Mah1
SET @Tarikh2=@Tasal1*100+@Tamah1

select fldTitle,sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh from(
SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(m.fldId)  OVER (PARTITION BY fldCostCenterId) AS fldTedad
, ((isnull(item.fldMablagh,0)+isnull(mo.fldMablagh,0) +isnull(o.fldMablaghMoavagh,0)+isnull(motamam.fldMablaghMotamam,0))
+isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,1 )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
)-(isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
						
)
as fldMablagh
FROM         Pay.tblMohasebat as m INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
					  cross apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMohasebat_Items as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear*100+m2.fldMonth between @Tarikh1  and @Tarikh2  AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)item
					  outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeParamId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)mo
					   outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablaghMoavagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMoavaghat as o on o.fldMohasebatId=m2.fldId inner join
									pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)o
					   outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId=1
								and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId
                                 )motamam
                      WHERE fldYear*100+fldMonth between @Tarikh1  and @Tarikh2 
                       AND m.fldNobatPardakht=@Nobat1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
					    and fldCalcType=@CalcType
					   and (item.fldMablagh>=0 or mo.fldMablagh>=0))t
	group by fldTitle
end	 
                      
IF(@fieldName1='ChartOrgan')
SELECT DISTINCT    fldTitle,COUNT(m.fldId) OVER (PARTITION BY fldCostCenterId) AS fldTedad
,  ((isnull(item.fldMablagh,0)+isnull(mo.fldMablagh,0) +isnull(o.fldMablaghMoavagh,0)+isnull(motamam.fldMablaghMotamam,0))
+isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,1 )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
)-(isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
						
)
as fldMablagh
FROM         Pay.tblMohasebat as m INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
					  cross apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMohasebat_Items as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND    m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId)item
					  outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeParamId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)mo
					  outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablaghMoavagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMoavaghat as o on o.fldMohasebatId=m2.fldId inner join
									pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId)o
					   outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId=1
                                and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId
							   )motamam
                      WHERE fldYear=@Sal1 AND fldMonth=@Mah1 AND fldNobatPardakht=@Nobat1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
					   and fldCalcType=@CalcType
                      and (item.fldMablagh>=0 or mo.fldMablagh>=0)
                      
 IF(@fieldName1='ChartOrgan_Sal')
 BEGIN
SET @Tarikh1=@Sal1*100+@Mah1
SET @Tarikh2=@Tasal1*100+@Tamah1
select fldTitle,sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh from(
SELECT DISTINCT    fldTitle,COUNT(m.fldId) OVER (PARTITION BY fldCostCenterId) AS fldTedad
,  ((isnull(item.fldMablagh,0)+isnull(mo.fldMablagh,0) +isnull(o.fldMablaghMoavagh,0)+isnull(motamam.fldMablaghMotamam,0))
+isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,1 )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
)-(isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@Nobat ,1 )),0)
						
)
as fldMablagh
FROM         Pay.tblMohasebat as m INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId  INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
					  cross apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMohasebat_Items as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear*100+m2.fldMonth between @Tarikh1  and @Tarikh2  AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId)item
					  outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m2.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeParamId=1 and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId)mo
					   outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablaghMoavagh FROM         Pay.tblMohasebat as m2 INNER JOIN
									Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId INNER JOIN
									pay.tblMoavaghat as o on o.fldMohasebatId=m2.fldId inner join
									pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId 
									WHERE m2.fldYear=@Sal1 AND m2.fldMonth=@Mah1 AND m2.fldNobatPardakht=@Nobat1  AND p.fldOrganId=@organId1
									 and fldCalcType=@CalcType
					  and i.fldHesabTypeItemId=1 and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId)o
					   outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP  and o.fldHesabTypeItemId=1
								 and p.fldChartOrganId=tblMohasebat_PersonalInfo.fldChartOrganId
                                 )motamam
                      WHERE fldYear*100+fldMonth between @Tarikh1  and @Tarikh2 
                       AND fldNobatPardakht=@Nobat1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1      
					    and fldCalcType=@CalcType   
					   and (item.fldMablagh>=0 or mo.fldMablagh>=0)
 )t
	group by fldTitle
end	 
GO
