SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptSumMotalebat_Kosurat](@fieldname NVARCHAR(50), @sal SMALLINT ,@month TINYINT,@CostCenter INT ,@typeBime INT,@nobat TINYINT,@OrganId INT,@CalcType TINYINT=1)
AS
--DECLARE @fieldname NVARCHAR(50)='Kosurat', @sal SMALLINT =1397,@month TINYINT=8,@CostCenter INT=1 ,@typeBime INT=1,@nobat TINYINT=1,@OrganId INT
IF(@fieldname='Kosurat')
SELECT DISTINCT ISNULL((SELECT CAST(fldTitle COLLATE Latin1_General_CI_AI AS NVARCHAR(MAX)) FROM Pay.tblParametrs WHERE fldid=Pay.tblKosorateParametri_Personal.fldParametrId ),'')fldTitle, ISNULL(SUM(cast([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh AS BIGINT))  OVER (PARTITION BY fldParametrId) ,0)AS fldMablagh
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      [Pay].[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblKosorateParametri_Personal.fldId = [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      WHERE [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId IS NOT NULL AND Pay.tblMohasebat.fldYear= @sal AND fldMonth=@month AND fldCostCenterId=@CostCenter AND fldTypeBimeId=@typeBime
                      AND fldNobatPardakht=@nobat AND Com.fn_OrganId(Pay.tblKosorateParametri_Personal.fldPersonalId)=@OrganId and fldCalcType=@CalcType
                       --GROUP BY fldParametrId,fldTitle
 UNION all
SELECT     ISNULL((tblBank.fldBankName + N' شعبه ' + tblShobe.fldName),''), ISNULL(CAST(SUM(Pay.tblMohasebat_KosoratBank.fldMablagh)AS BIGINT),0) AS fldMablagh
                      
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe  ON Pay.tblKosuratBank.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank  ON tblShobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      WHERE Pay.tblMohasebat.fldNobatPardakht=@nobat AND fldYear=@sal AND fldMonth=@Month
                       AND  fldCostCenterId=@CostCenter AND fldTypeBimeId=@typeBime AND Com.fn_organIdWithPayPersonal(Pay.tblKosuratBank.fldPersonalId)=@OrganId and fldCalcType=@CalcType
                       GROUP BY tblBank.fldBankName, tblSHobe.fldName                      
                       
                       
IF(@fieldname='Motalebat')
SELECT     ISNULL(Pay.tblParametrs.fldTitle,'')fldTitle, ISNULL(SUM(CAST(Pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh AS BIGINT)),0)AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMohasebat.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId ON 
                      Pay.[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId
                      WHERE [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId IS NOT NULL AND Pay.tblMohasebat.fldYear=@sal AND fldMonth=@month AND fldCostCenterId=@CostCenter AND fldTypeBimeId=@typeBime
                      AND Pay.tblMohasebat.fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(Pay.tblMotalebateParametri_Personal.fldPersonalId)=@OrganId and fldCalcType=@CalcType
                       GROUP BY fldParametrId,fldTitle
GO
