SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptMande_SumKosurat](@FieldName NVARCHAR(50),@year NVARCHAR(4),@mah NVARCHAR(2),@nobat TINYINT,@ParamId INT,@CostCenterId INT,@OrganId INT,@CalcType TINYINT=1)
AS
BEGIN TRAN
DECLARE @r NVARCHAR(10)
SET @r=CASE WHEN LEN (@mah)=1 THEN CAST(@Year AS NVARCHAR(4))+'0'+CAST(@mah AS NVARCHAR(2)) ELSE CAST(@Year AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2)) END 

IF(@FieldName='Jam')
SELECT distinct    SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh) OVER (PARTITION BY [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId) + Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl AS fldKol , tblEmployee.fldName, 
                      tblEmployee.fldFamily, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle,fldFatherName, [Pay].[tblMohasebat_kosorat/MotalebatParam] .fldMablagh
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
WHERE  pay.tblKosorateParametri_Personal.fldDateDeactive >=CAST(@r AS INT) AND fldNobatPardakht=@nobat  AND fldParametrId=@ParamId
 AND (Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId or @CostCenterId=0)
AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId and fldCalcType=@CalcType

IF(@FieldName='Mande')
SELECT  distinct fldMondeGHabl-  SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh) OVER (PARTITION BY [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId) AS fldKol , tblEmployee.fldName, 
                      tblEmployee.fldFamily, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle,fldFatherName, [Pay].[tblMohasebat_kosorat/MotalebatParam] .fldMablagh
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
WHERE  pay.tblKosorateParametri_Personal.fldDateDeactive >=CAST(@r AS INT) AND fldNobatPardakht=@nobat  AND fldParametrId=@ParamId 
 AND (Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId or @CostCenterId=0)
AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId and fldCalcType=@CalcType
GO
