SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_OrganWithChartId] (@FieldName NVARCHAR(50),@ChartId INT)
RETURNS INT
AS
BEGIN
DECLARE @Id INT,@organid INT
IF(@FieldName='ChartOrgan')
BEGIN
;WITH temp AS (
SELECT fldId,fldOrganId,fldTitle,fldPId FROM Com.tblChartOrgan
WHERE fldId=@ChartId
UNION ALL
SELECT       c.fldid, c.fldOrganId,c.fldTitle,c.fldPId
FROM           temp AS t INNER JOIN
                         Com.tblChartOrgan AS c ON t.fldPId = c.fldId
						
          )   
SELECT @organid=temp.fldOrganId FROM temp 
WHERE temp.fldOrganId IS NOT NULL   
END

IF(@FieldName='ChartOrganEjra')
BEGIN
;WITH temp AS (
SELECT fldId,fldOrganId,fldTitle,fldPId FROM Com.tblChartOrganEjraee
WHERE fldId=@ChartId
UNION ALL
SELECT       c.fldid, c.fldOrganId,c.fldTitle,c.fldPId
FROM           temp AS t INNER JOIN
                         Com.tblChartOrganEjraee AS c ON t.fldPId = c.fldId
						
          )   
SELECT @organid=temp.fldOrganId FROM temp 
WHERE temp.fldOrganId IS NOT NULL   
END

RETURN @organid
end
GO
