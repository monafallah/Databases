SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseEzafekar_TatilKar](@fieldName NVARCHAR(50), @sal SMALLINT ,@mah TINYINT ,@Nobat TINYINT,@OrganId INT,@Tasal SMALLINT,@Tamah TINYINT)
AS
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINT
IF(@fieldName='EzafeKar_CostCenter')


	SELECT DISTINCT   Pay.tblCostCenter.fldTitle ,COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Maliyat, 
						  CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
						  CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
	FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE  fldType=1 AND fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId


IF(@fieldName='EzafeKar_ChartOrgan')

	SELECT DISTINCT   Com.tblChartOrganEjraee.fldTitle ,COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Maliyat, 
						  CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
						  CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
	FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
						  WHERE  fldType=1 AND fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId



IF(@fieldName='EzafeKar_CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end
SELECT fldTitle,SUM(Tedad)Tedad,sum(Mablagh),sum(Maliyat)Maliyat,SUM(TaaminEjtemaee)TaaminEjtemaee,SUM(Bazneshastegi)Bazneshastegi
FROM (SELECT DISTINCT   Pay.tblCostCenter.fldTitle ,COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Maliyat, 
						  CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
						  CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
	FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
						  WHERE  fldType=1 AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS bigint) end between @Tarikh1  and @Tarikh2 
						   AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId


)t
	group by fldTitle
end


IF(@fieldName='EzafeKar_ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end
SELECT fldTitle,SUM(Tedad)Tedad,sum(Mablagh),sum(Maliyat)Maliyat,SUM(TaaminEjtemaee)TaaminEjtemaee,SUM(Bazneshastegi)Bazneshastegi
FROM(SELECT DISTINCT   Com.tblChartOrganEjraee.fldTitle ,COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Maliyat, 
						  CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
						  CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
	FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
						  WHERE  fldType=1 AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
						   AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
)t
	group by fldTitle

END

IF(@fieldName='TatilKar_CostCenter')	        
SELECT DISTINCT  Pay.tblCostCenter.fldTitle, COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Maliyat, 
                      CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
                      CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE  fldType=2 AND fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId             


IF(@fieldName='TatilKar_CostCenter_Sal')	
BEGIN    
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,sum(Mablagh),sum(Maliyat)Maliyat,SUM(TaaminEjtemaee)TaaminEjtemaee,SUM(Bazneshastegi)Bazneshastegi
FROM(SELECT DISTINCT  Pay.tblCostCenter.fldTitle, COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Maliyat, 
                      CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
                      CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE  fldType=2 AND  CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS NVARCHAR(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                       AND fldNobatPardakht=@Nobat  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId             
)t
	group by fldTitle


end
IF(@fieldName='TatilKar_ChartOrgan')	        
SELECT DISTINCT tblChartOrganEjraee.fldTitle, COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Maliyat, 
                      CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
                      CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                      WHERE  fldType=2 AND fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId             


IF(@fieldName='TatilKar_ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,sum(Mablagh),sum(Maliyat)Maliyat,SUM(TaaminEjtemaee)TaaminEjtemaee,SUM(Bazneshastegi)Bazneshastegi	        
FROM (SELECT DISTINCT tblChartOrganEjraee.fldTitle, COUNT (Pay.tblMohasebatEzafeKari_TatilKari.fldId)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,   SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Mablagh, SUM(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Maliyat, 
                      CASE WHEN fldTypeBimeId = 1 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS TaaminEjtemaee, 
                      CASE WHEN fldTypeBimeId = 2 THEN SUM(fldBimePersonal + fldBimeKarFarma + fldBimeBikari)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END AS Bazneshastegi
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
						  Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                      WHERE  fldType=2 AND CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                      AND fldNobatPardakht=@Nobat  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId             

)t
	group by fldTitle
end


GO
