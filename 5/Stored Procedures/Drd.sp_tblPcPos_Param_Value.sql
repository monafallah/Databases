SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [Drd].[sp_tblPcPos_Param_Value]
@Value int
as 
BEGIN
DECLARE @fldPspId INT
SELECT @fldPspId=fldPspId FROM drd.tblPcPosInfo WHERE fldid=@Value
SELECT     tblPcPosParametr.fldId, tblPcPosParametr.fldFaName, tblPcPosParametr.fldEnName, 
CASE WHEN fldid IN (SELECT fldPcPosParamId FROM drd.tblPcPosParam_Detail WHERE fldPcPosInfoId=@Value AND fldPcPosParamId=tblPcPosParametr.fldId)
THEN (SELECT fldValue FROM drd.tblPcPosParam_Detail WHERE fldPcPosInfoId=@Value AND fldPcPosParamId=tblPcPosParametr.fldId) ELSE '' end
 AS fldValue
FROM         drd.tblPcPosParametr 
where fldPspId=@fldPspId 


end
GO
