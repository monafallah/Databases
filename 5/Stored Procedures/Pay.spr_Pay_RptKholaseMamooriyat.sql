SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseMamooriyat](@fieldName NVARCHAR(50),@sal SMALLINT,@Mah TINYINT ,@nobat TINYINT,@OrganId INT,@Tasal SMALLINT,@Tamah TINYINT)
AS
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINT
IF(@fieldName='CostCenter')
SELECT  DISTINCT  Pay.tblCostCenter.fldTitle,COUNT(Pay.tblMohasebat_Mamuriyat.fldId) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,sum (Pay.tblMohasebat_Mamuriyat.fldMablagh)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS fldMablagh, 
                      SUM(Pay.tblMohasebat_Mamuriyat.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId)AS fldMaliyat, SUM(Pay.tblMohasebat_Mamuriyat.fldTashilat) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS fldTashilat
,SUM(fldTedadBaBeytute+fldTedadBedunBeytute)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS TedadBeytute,
CASE WHEN fldTypeBimeId=1 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END TaminEjtemaee
 ,CASE WHEN fldTypeBimeId=2 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END Baznashastegi

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId

IF(@fieldName='CostCenter_Sal')
BEGIN 
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,sum(fldMablagh)fldMablagh,sum(fldMaliyat)fldMaliyat,sum(fldTashilat)fldTashilat,SUM(TedadBeytute)TedadBeytute,sum(TaminEjtemaee)TaminEjtemaee,SUM(Baznashastegi)Baznashastegi
FROM(SELECT  DISTINCT  Pay.tblCostCenter.fldTitle,COUNT(Pay.tblMohasebat_Mamuriyat.fldId) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS Tedad,sum (Pay.tblMohasebat_Mamuriyat.fldMablagh)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS fldMablagh, 
                      SUM(Pay.tblMohasebat_Mamuriyat.fldMaliyat)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId)AS fldMaliyat, SUM(Pay.tblMohasebat_Mamuriyat.fldTashilat) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS fldTashilat
,SUM(fldTedadBaBeytute+fldTedadBedunBeytute)OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) AS TedadBeytute,
CASE WHEN fldTypeBimeId=1 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END TaminEjtemaee
 ,CASE WHEN fldTypeBimeId=2 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldCostCenterId,fldTypeBimeId) ELSE 0 END Baznashastegi

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE (CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))AS bigint)+cast(CAST(+'0'+fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) END) between @Tarikh1  and @Tarikh2 
                       AND fldNobatePardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
)t
	group by fldTitle
end   


IF(@fieldName='ChartOrgan')
SELECT  DISTINCT     com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblMohasebat_Mamuriyat.fldId) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,sum (Pay.tblMohasebat_Mamuriyat.fldMablagh)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS fldMablagh, 
                      SUM(Pay.tblMohasebat_Mamuriyat.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId)AS fldMaliyat, SUM(Pay.tblMohasebat_Mamuriyat.fldTashilat) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS fldTashilat
,SUM(fldTedadBaBeytute+fldTedadBedunBeytute)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS TedadBeytute,
CASE WHEN fldTypeBimeId=1 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END TaminEjtemaee
 ,CASE WHEN fldTypeBimeId=2 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END Baznashastegi

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                        com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId =   com.tblChartOrganEjraee.fldId
                      WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId

IF(@fieldName='ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS bigint) end    
SELECT fldTitle,SUM(Tedad)Tedad,sum(fldMablagh)fldMablagh,sum(fldMaliyat)fldMaliyat,sum(fldTashilat)fldTashilat,SUM(TedadBeytute)TedadBeytute,sum(TaminEjtemaee)TaminEjtemaee,SUM(Baznashastegi)Baznashastegi
FROM(SELECT  DISTINCT     com.tblChartOrganEjraee.fldTitle,COUNT(Pay.tblMohasebat_Mamuriyat.fldId) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS Tedad,sum (Pay.tblMohasebat_Mamuriyat.fldMablagh)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS fldMablagh, 
                      SUM(Pay.tblMohasebat_Mamuriyat.fldMaliyat)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId)AS fldMaliyat, SUM(Pay.tblMohasebat_Mamuriyat.fldTashilat) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS fldTashilat
,SUM(fldTedadBaBeytute+fldTedadBedunBeytute)OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) AS TedadBeytute,
CASE WHEN fldTypeBimeId=1 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END TaminEjtemaee
 ,CASE WHEN fldTypeBimeId=2 then SUM(Pay.tblMohasebat_Mamuriyat.fldBimePersonal+Pay.tblMohasebat_Mamuriyat.fldBimeKarFarma+Pay.tblMohasebat_Mamuriyat.fldBimeBikari) OVER (PARTITION BY fldChartOrganId,fldTypeBimeId) ELSE 0 END Baznashastegi

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                        com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId =   com.tblChartOrganEjraee.fldId
                      WHERE (CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))AS bigint)+cast(CAST(+'0'+fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) END) between @Tarikh1  and @Tarikh2  AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId

)t
	group by fldTitle
end 
GO
