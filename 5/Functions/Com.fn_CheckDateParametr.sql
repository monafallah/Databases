SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_CheckDateParametr](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10))
RETURNS BIT
AS
BEGIN	
DECLARE  @r BIT=0
IF (@TaTarikh IS NULL)
SELECT @r=1 FROM Drd.tblParametreOmoomi_Value
WHERE @AzTarikh BETWEEN fldFromDate AND fldEndDate
ELSE
BEGIN 
IF(SELECT COUNT(*) FROM Drd.tblParametreOmoomi_Value
WHERE (fldFromDate BETWEEN @AzTarikh AND @TaTarikh
OR fldEndDate BETWEEN @AzTarikh AND @TaTarikh
OR @AzTarikh BETWEEN fldFromDate AND fldEndDate
OR @TaTarikh BETWEEN fldFromDate AND fldEndDate ) )>1
SET @r=1
END

RETURN @r
END 
GO
