SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseSayerPardakht](@fieldName NVARCHAR(50),@Sal SMALLINT,@Mah TINYINT,@Nobat TINYINT,@marhale TINYINT,@organId INT,@Tasal SMALLINT,@Tamah TINYINT)
AS
declare @fieldName1 NVARCHAR(50),@Sal1 SMALLINT,@Mah1 TINYINT,@Nobat1 TINYINT,@marhale1 TINYINT,@organId1 INT,@Tasal1 SMALLINT,@Tamah1 TINYINT
set @fieldName1=@fieldName
set @Sal1=@Sal
set @Mah1=@Mah
set @Nobat1=@Nobat
set @marhale1=@marhale
set @organId1=@organId
set @Tasal1=@Tasal
set @Tamah1=@Tamah
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINt
IF(@fieldName1='CostCenter')
SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(Pay.tblSayerPardakhts.fldId) OVER (PARTITION BY fldCostCenterId) AS fldTedad, SUM(CAST(Pay.tblSayerPardakhts.fldAmount AS BIGINT)) OVER (PARTITION BY fldCostCenterId)fldMablagh, SUM(Pay.tblSayerPardakhts.fldMaliyat) OVER (PARTITION BY fldCostCenterId) AS fldMaliyat
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE fldYear=@Sal1 AND fldMonth=@Mah1 AND fldNobatePardakt=@Nobat1 AND fldMarhalePardakht=@marhale1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1

IF(@fieldName1='CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@Mah1)=1 THEN cast(CAST(@Sal1 AS NVARCHAR(4))+'0'+CAST(@Mah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Sal1 AS NVARCHAR(4))+CAST(@Mah1 AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(2))AS bigint) end
SELECT fldTitle,sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh,sum(fldMaliyat)fldMaliyat
FROM (SELECT DISTINCT    Pay.tblCostCenter.fldTitle,COUNT(Pay.tblSayerPardakhts.fldId) OVER (PARTITION BY fldCostCenterId) AS fldTedad, SUM(CAST(Pay.tblSayerPardakhts.fldAmount AS BIGINT)) OVER (PARTITION BY fldCostCenterId)fldMablagh, SUM(Pay.tblSayerPardakhts.fldMaliyat) OVER (PARTITION BY fldCostCenterId) AS fldMaliyat
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                       AND fldNobatePardakt=@Nobat1 AND fldMarhalePardakht=@marhale1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
 )t
	group by fldTitle
end	 
                      
IF(@fieldName1='ChartOrgan')
SELECT DISTINCT    tblChartOrganEjraee.fldTitle,COUNT(Pay.tblSayerPardakhts.fldId) OVER (PARTITION BY fldChartOrganId) AS fldTedad, SUM(CAST(Pay.tblSayerPardakhts.fldAmount AS BIGINT)) OVER (PARTITION BY fldChartOrganId)fldMablagh, SUM(Pay.tblSayerPardakhts.fldMaliyat) OVER (PARTITION BY fldChartOrganId) AS fldMaliyat
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
                      WHERE fldYear=@Sal1 AND fldMonth=@Mah1 AND fldNobatePardakt=@Nobat1 AND fldMarhalePardakht=@marhale1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
                      
                      
 IF(@fieldName1='ChartOrgan_Sal')
 BEGIN
SET @Tarikh1=CASE WHEN LEN(@Mah1)=1 THEN cast(CAST(@Sal1 AS NVARCHAR(4))+'0'+CAST(@Mah1 AS nvarchar(1))AS bigint) ELSE cast(CAST(@Sal1 AS NVARCHAR(4))+CAST(@Mah1 AS nvarchar(1))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@Tamah1)=1 THEN cast(CAST(@Tasal1 AS NVARCHAR(4))+'0'+CAST(@Tamah1 AS nvarchar(1))AS bigint) ELSE cast(CAST(@Tasal1 AS NVARCHAR(4))+CAST(@Tamah1 AS nvarchar(1))AS bigint) end
SELECT fldTitle,sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh,sum(fldMaliyat)fldMaliyat
FROM (SELECT DISTINCT    tblChartOrganEjraee.fldTitle,COUNT(Pay.tblSayerPardakhts.fldId) OVER (PARTITION BY fldChartOrganId) AS fldTedad, SUM(CAST(Pay.tblSayerPardakhts.fldAmount AS BIGINT)) OVER (PARTITION BY fldChartOrganId)fldMablagh, SUM(Pay.tblSayerPardakhts.fldMaliyat) OVER (PARTITION BY fldChartOrganId) AS fldMaliyat
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = com.tblChartOrganEjraee.fldId
                      WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                       AND fldNobatePardakt=@Nobat1 AND fldMarhalePardakht=@marhale1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1                     
 )t
	group by fldTitle
end	 
GO
