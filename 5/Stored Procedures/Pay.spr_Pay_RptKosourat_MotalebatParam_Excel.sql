SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [Pay].[spr_Pay_RptKosourat_MotalebatParam_Excel]
@Year SMALLINT,
@Month TINYINT,
@ParametrId int,
@organId INT,
@CalcType TINYINT=1
as

BEGIN TRAN
		SELECT        '"";"' + CAST(Pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh AS nvarchar(10)) + '";"'+ Com.tblEmployee.fldCodemeli+'";"' +Com.tblEmployee.fldName+' ' +Com.tblEmployee.fldFamily+'";"1"' as fldName
		FROM            Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
								 Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
								 Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
								 Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
								 Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId AND Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId AND 
								 Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId
		WHERE        (Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId IN
									 (SELECT        fldId
									   FROM            Pay.tblKosorateParametri_Personal
									   WHERE        (fldParametrId = @ParametrId))) AND (Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId IN
									 (SELECT        tblMohasebat_1.fldId
									   FROM            Pay.tblMohasebat AS tblMohasebat_1 INNER JOIN
																 Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
									   WHERE        (tblMohasebat_1.fldYear = @Year) AND (tblMohasebat_1.fldMonth =@Month) and fldCalcType=@CalcType 
									   AND (Pay.tblMohasebat_PersonalInfo.fldOrganId = @organId)))
commit tran
GO
