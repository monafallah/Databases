SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKosurat_MotalebatPardakhtShode](@fieldName NVARCHAR(50),@Sal SMALLINT,@mah TINYINT,@ParametrId INT,@CostCenter INT,@nobat TINYINT,@organId INT,
@CalcType TINYINT=1)
AS 
IF(@fieldName ='Kosurat')
BEGIN
	IF (@CostCenter<>0)
	SELECT    fldFamily + '_' + tblEmployee.fldName AS Name_Family, fldFatherName, tblEmployee.fldCodemeli, 
                      Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldDesc
FROM         Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblKosorateParametri_Personal ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						  WHERE fldYear=@Sal AND fldMonth=@mah AND fldParametrId=@ParametrId AND fldNobatPardakht=@nobat AND fldKosoratId IS not NULL AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenter
						  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType
						  ORDER BY fldFamily 

	                      
ELSE
	SELECT    fldFamily + '_' + tblEmployee.fldName AS Name_Family, fldFatherName, tblEmployee.fldCodemeli, 
                      Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldDesc
FROM         Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblKosorateParametri_Personal ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						  WHERE fldYear=@Sal AND fldMonth=@mah AND fldParametrId=@ParametrId AND fldNobatPardakht=@nobat AND fldKosoratId IS not NULL 
						  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType
						  ORDER BY fldFamily 
END  
IF(@fieldName='Motalebat')
BEGIN
	IF(@CostCenter<>0)
	SELECT    fldFamily + '_' + tblEmployee.fldName AS Name_Family, fldFatherName, tblEmployee.fldCodemeli, 
                      Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.[tblMohasebat_kosorat/MotalebatParam].fldDesc
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMotalebateParametri_Personal.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId INNER JOIN
                      Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						   WHERE fldYear=@Sal AND fldMonth=@mah AND fldParametrId=@ParametrId AND fldNobatPardakht=@nobat AND fldMotalebatId IS not NULL  AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenter
							AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType
							ORDER BY fldFamily 

	ELSE
SELECT     fldFamily + '_' + tblEmployee.fldName AS Name_Family, fldFatherName, tblEmployee.fldCodemeli, 
                      Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.[tblMohasebat_kosorat/MotalebatParam].fldDesc
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMotalebateParametri_Personal.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId INNER JOIN
                      Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						   WHERE fldYear=@Sal AND fldMonth=@mah AND fldParametrId=@ParametrId AND fldNobatPardakht=@nobat AND fldMotalebatId IS not NULL 
							AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType
							ORDER BY fldFamily 
END


GO
