SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_CheckRengeDate](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10))
RETURNS BIT
AS
BEGIN
DECLARE @r BIT=0
SELECT @r=1 FROM com.tblMaliyatArzesheAfzoode 
WHERE fldFromDate BETWEEN @AzTarikh AND @TaTarikh
OR fldEndDate BETWEEN @AzTarikh AND @TaTarikh
OR @AzTarikh BETWEEN fldFromDate AND fldEndDate
OR @TaTarikh BETWEEN fldFromDate AND fldEndDate
RETURN @r
end
GO
