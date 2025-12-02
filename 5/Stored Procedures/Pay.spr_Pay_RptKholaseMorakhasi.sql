SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKholaseMorakhasi](@fieldname NVARCHAR(50),@sal SMALLINT ,@mah TINYINT,@NobatPardakht TINYINT,@organId INT,@Tasal SMALLINT,@Tamah TINYINT )
AS
DECLARE @Tarikh1 BIGINT,@Tarikh2 BIGINt
IF(@fieldname='CostCenter')
SELECT    COUNT(Pay.tblMohasebat_Morakhasi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad , Pay.tblCostCenter.fldTitle,SUM(Pay.tblMohasebat_Morakhasi.fldMablagh) OVER (PARTITION BY fldCostCenterId)  AS fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE fldYear =@sal AND fldMonth=@mah AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId

IF(@fieldname='CostCenter_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS BIGINT) ELSE CAST(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS NVARCHAR(2))AS bigint) end
SELECT SUM(Tedad)Tedad,fldTitle,SUM(fldMablagh)fldMablagh
FROM(SELECT    COUNT(Pay.tblMohasebat_Morakhasi.fldId) OVER (PARTITION BY fldCostCenterId) AS Tedad , Pay.tblCostCenter.fldTitle,SUM(Pay.tblMohasebat_Morakhasi.fldMablagh) OVER (PARTITION BY fldCostCenterId)  AS fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
                      WHERE CASE WHEN LEN(fldMonth)=1 THEN cast(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS nvarchar(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                       AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
)t
	group by fldTitle
end	

IF(@fieldname='ChartOrgan')
SELECT    COUNT(Pay.tblMohasebat_Morakhasi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , Com.tblChartOrganEjraee.fldTitle,SUM(Pay.tblMohasebat_Morakhasi.fldMablagh) OVER (PARTITION BY fldChartOrganId)  AS fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                      WHERE fldYear =@sal AND fldMonth=@mah AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId

IF(@fieldname='ChartOrgan_Sal')
BEGIN
SET @Tarikh1=CASE WHEN LEN(@mah)=1 THEN cast(CAST(@sal AS NVARCHAR(4))+'0'+CAST(@mah AS nvarchar(2))AS bigint) ELSE cast(CAST(@sal AS NVARCHAR(4))+CAST(@mah AS nvarchar(2))AS bigint) end
SET @Tarikh2=CASE WHEN LEN(@tamah)=1 THEN cast(CAST(@Tasal AS NVARCHAR(4))+'0'+CAST(@Tamah AS nvarchar(2))AS bigint) ELSE cast(CAST(@Tasal AS NVARCHAR(4))+CAST(@Tamah AS nvarchar(2))AS BIGINT) END
SELECT SUM(Tedad)Tedad,fldTitle,SUM(fldMablagh)fldMablagh
FROM(SELECT    COUNT(Pay.tblMohasebat_Morakhasi.fldId) OVER (PARTITION BY fldChartOrganId) AS Tedad , Com.tblChartOrganEjraee.fldTitle,SUM(Pay.tblMohasebat_Morakhasi.fldMablagh) OVER (PARTITION BY fldChartOrganId)  AS fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblChartOrganEjraee ON Pay.tblMohasebat_PersonalInfo.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                      WHERE CASE WHEN LEN(fldMonth)=1 THEN CAST(CAST(fldYear AS NVARCHAR(4))+'0'+CAST(fldMonth AS NVARCHAR(2))AS bigint) ELSE cast(CAST(fldYear AS NVARCHAR(4))+CAST(fldMonth AS nvarchar(2))AS bigint) end between @Tarikh1  and @Tarikh2 
                       AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
)t
	group by fldTitle
END
GO
