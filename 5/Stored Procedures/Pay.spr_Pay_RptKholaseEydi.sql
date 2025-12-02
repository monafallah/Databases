SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseEydi] (@fieldname NVARCHAR(50),@sal SMALLINT,@mah TINYINT,@nobat TINYINT,@OrganId INT,@Tasal SMALLINT,@tamah TINYINT)
AS
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINT

IF(@fieldname='CostCenter')
SELECT   DISTINCT  count (Pay.tblMohasebat_Eydi.fldId)  OVER(PARTITION BY fldCostCenterId) AS fldTedad,   Pay.tblCostCenter.fldTitle, sum (cast(Pay.tblMohasebat_Eydi.fldMablagh as bigint)) OVER(PARTITION BY fldCostCenterId) AS fldMablagh,SUM(cast( Pay.tblMohasebat_Eydi.fldKosurat as bigint))  OVER(PARTITION BY fldCostCenterId) AS fldKosurat, SUM(cast(Pay.tblMohasebat_Eydi.fldMaliyat as bigint))  OVER(PARTITION BY fldCostCenterId) AS fldMaliyat

FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE fldYear=@sal AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId

IF(@fieldname='ChartOrgan')
SELECT   DISTINCT  count (Pay.tblMohasebat_Eydi.fldId)  OVER(PARTITION BY fldChartOrganId) AS fldTedad,   tblChartOrganEjraee.fldTitle, sum (cast(Pay.tblMohasebat_Eydi.fldMablagh as bigint)) OVER(PARTITION BY fldChartOrganId) AS fldMablagh,SUM(cast( Pay.tblMohasebat_Eydi.fldKosurat as bigint))  OVER(PARTITION BY fldChartOrganId) AS fldKosurat, SUM(cast(Pay.tblMohasebat_Eydi.fldMaliyat as bigint))  OVER(PARTITION BY fldChartOrganId) AS fldMaliyat


FROM            Pay.tblMohasebat_Eydi INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                         Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                        WHERE tblMohasebat_Eydi.fldYear=@sal AND tblMohasebat_Eydi.fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                        

IF(@fieldname='CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end
                      
  SELECT  sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh,fldTitle ,SUM(fldKosurat)fldKosurat,SUM(fldMaliyat)fldMaliyat
from  (select   DISTINCT  count (Pay.tblMohasebat_Eydi.fldId)  OVER(PARTITION BY fldCostCenterId,fldYear,fldMonth) AS fldTedad,   Pay.tblCostCenter.fldTitle, sum (cast(Pay.tblMohasebat_Eydi.fldMablagh as bigint)) OVER(PARTITION BY fldCostCenterId,fldYear,fldMonth) AS fldMablagh,SUM( cast(Pay.tblMohasebat_Eydi.fldKosurat as bigint))  OVER(PARTITION BY fldCostCenterId,fldYear,fldMonth) AS fldKosurat, SUM(cast(Pay.tblMohasebat_Eydi.fldMaliyat as bigint))  OVER(PARTITION BY fldCostCenterId,fldYear,fldMonth) AS fldMaliyat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE  fldYear BETWEEN @sal AND @Tasal --CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
					  AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
)t
						group by fldTitle     
END

IF(@fieldname='ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end
                      
  SELECT sum(fldTedad)fldTedad,sum(fldMablagh)fldMablagh,fldTitle ,SUM(fldKosurat)fldKosurat,SUM(fldMaliyat)fldMaliyat
FROM(SELECT   DISTINCT  count (Pay.tblMohasebat_Eydi.fldId)  OVER(PARTITION BY fldChartOrganId) AS fldTedad,   tblChartOrganEjraee.fldTitle, sum (cast(Pay.tblMohasebat_Eydi.fldMablagh as bigint)) OVER(PARTITION BY fldChartOrganId) AS fldMablagh,SUM( cast(Pay.tblMohasebat_Eydi.fldKosurat as bigint))  OVER(PARTITION BY fldChartOrganId) AS fldKosurat, SUM(cast(Pay.tblMohasebat_Eydi.fldMaliyat as bigint))  OVER(PARTITION BY fldChartOrganId) AS fldMaliyat
FROM            Pay.tblMohasebat_Eydi INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                         Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                        WHERE fldYear BETWEEN @sal AND @Tasal --CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                         AND tblMohasebat_Eydi.fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
  )t
						group by fldTitle
  
  END               
GO
