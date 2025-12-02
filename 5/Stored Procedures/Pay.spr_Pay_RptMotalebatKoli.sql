SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptMotalebatKoli](@NobatePardakht TINYINT,@Year SMALLINT,@Month TINYINT,@organId INT,@CalcType TINYINT=1)
AS

SELECT     Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, SUM(cast([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh as bigint)) AS fldMablagh, Pay.tblMohasebat.fldYear, 
                      Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=Pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.tblMotalebateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
                      WHERE fldNobatPardakht=@NobatePardakht AND fldYear=@Year AND fldMonth=@Month AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType
GROUP BY Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle,fldYear,fldMonth
GO
