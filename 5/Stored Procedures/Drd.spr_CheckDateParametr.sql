SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckDateParametr](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10))
AS
IF (@TaTarikh IS NULL )AND EXISTS(SELECT fldId FROM Drd.tblParametreOmoomi_Value
WHERE @AzTarikh BETWEEN fldFromDate AND fldEndDate)
SELECT fldId FROM Drd.tblParametreOmoomi_Value
WHERE @AzTarikh BETWEEN fldFromDate AND fldEndDate
ELSE IF EXISTS(SELECT fldId FROM Drd.tblParametreOmoomi_Value
WHERE fldFromDate BETWEEN @AzTarikh AND @TaTarikh
OR fldEndDate BETWEEN @AzTarikh AND @TaTarikh
OR @AzTarikh BETWEEN fldFromDate AND fldEndDate
OR @TaTarikh BETWEEN fldFromDate AND fldEndDate)
SELECT fldId FROM Drd.tblParametreOmoomi_Value
WHERE fldFromDate BETWEEN @AzTarikh AND @TaTarikh
OR fldEndDate BETWEEN @AzTarikh AND @TaTarikh
OR @AzTarikh BETWEEN fldFromDate AND fldEndDate
OR @TaTarikh BETWEEN fldFromDate AND fldEndDate
ELSE
SELECT 0 AS fldId
GO
