SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseKomak](@FieldName NVARCHAR(50),@Sal SMALLINT,@mah TINYINT,@organId INT,@Tasal SMALLINT,@Tamah TINYINT)
AS
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINT
IF(@FieldName='Mostamar_CostCenter')

	SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad 
	, SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY fldCostCenterId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldCostCenterId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE fldNoeMostamer=1 AND fldYear=@Sal AND fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  
  
  
  
IF(@FieldName='Mostamar_CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,SUM(fldMablagh)fldMablagh,SUM(fldMaliyat)fldMaliyat
FROM(SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY fldCostCenterId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldCostCenterId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE fldNoeMostamer=1 AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
						   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  
)t
	group by fldTitle
end    
IF(@FieldName='Mostamar_ChartOrgan')

	SELECT DISTINCT     com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY fldChartOrganId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldChartOrganId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
						  WHERE fldNoeMostamer=1 AND fldYear=@Sal AND fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  
	

IF(@FieldName='Mostamar_ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2))AS BIGINT) END
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN CAST(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS NVARCHAR(2))AS BIGINT) END    
SELECT fldTitle,SUM(Tedad)Tedad,SUM(fldMablagh)fldMablagh,SUM(fldMaliyat)fldMaliyat
FROM(SELECT DISTINCT     com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY fldChartOrganId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldChartOrganId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
						  WHERE fldNoeMostamer=1 AND  CASE WHEN LEN(fldMonth)=1 THEN CAST(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS BIGINT) END BETWEEN @Tarikh1  AND @Tarikh2 
						   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  
)t
	GROUP BY fldTitle
END
	                
IF(@FieldName='GheyrMostamar_CostCenter')

	SELECT  DISTINCT   Pay.tblCostCenter.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY  fldCostCenterId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldCostCenterId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE fldNoeMostamer=0  AND fldYear=@Sal AND fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId           

IF(@FieldName='GheyrMostamar_CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN CAST(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2))AS BIGINT) END
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN CAST(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS NVARCHAR(2))AS BIGINT) ELSE CAST(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS NVARCHAR(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,SUM(fldMablagh)fldMablagh,SUM(fldMaliyat)fldMaliyat
FROM(SELECT  DISTINCT   Pay.tblCostCenter.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY  fldCostCenterId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldCostCenterId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE fldNoeMostamer=0  AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
						   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId           
)t
	group by fldTitle
end

IF(@FieldName='GheyrMostamar_ChartOrgan')

	SELECT  DISTINCT   com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY  fldChartOrganId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldChartOrganId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						   com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
						  WHERE fldNoeMostamer=0  AND fldYear=@Sal AND fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId           


IF(@FieldName='GheyrMostamar_ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,SUM(fldMablagh)fldMablagh,SUM(fldMaliyat)fldMaliyat
FROM(SELECT  DISTINCT   com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblKomakGheyerNaghdi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , SUM(cast(Pay.tblKomakGheyerNaghdi.fldMablagh as bigint)) OVER (PARTITION BY  fldChartOrganId ) AS fldMablagh, 
	SUM(Pay.tblKomakGheyerNaghdi.fldMaliyat) OVER (PARTITION BY  fldChartOrganId) AS fldMaliyat
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
						   com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
						  WHERE fldNoeMostamer=0  AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
						   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId           
)t
	group by fldTitle
end

GO
