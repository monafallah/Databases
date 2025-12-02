SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKosorat_MotalebatParametri]
@StartDate NVARCHAR(10),
@EndDate NVARCHAR(10),
@ParamId INT,
@fieldname nvarchar(50),
@OrganId INT
AS 
BEGIN TRAN
if (@fieldname=N'Kosorat')
SELECT  * FROM (SELECT   Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, Pay.tblKosorateParametri_Personal.fldTarikhePardakht, 
                      CASE WHEN (Pay.tblKosorateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, CASE WHEN (fldNoePardakht = 0) 
                      THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle, @StartDate AS StartDate, @EndDate AS EndDate
FROM         Pay.tblParametrs INNER JOIN
                      Pay.tblKosorateParametri_Personal ON Pay.tblParametrs.fldId = Pay.tblKosorateParametri_Personal.fldParametrId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId ON 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId 
                      WHERE fldParametrId=@ParamId AND fldTarikhePardakht BETWEEN @StartDate AND @EndDate AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId)t
					  ORDER BY fldName
                      
                      
if (@fieldname=N'Motalebat')                      
                  SELECT* FROM (   SELECT        Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, tblEmployee.fldCodemeli, 
                         Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.tblParametrs.fldTitle, CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, 
                         CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName, 
                         Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, @StartDate AS StartDate, @EndDate AS EndDate
FROM            Pay.tblMotalebateParametri_Personal INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                         Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
					     WHERE fldParametrId=@ParamId AND fldTarikhPardakht BETWEEN @StartDate AND @EndDate AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId)t
					    ORDER BY fldName

ROLLBACK
GO
