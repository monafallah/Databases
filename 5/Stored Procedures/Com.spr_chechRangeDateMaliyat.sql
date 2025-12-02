SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Com].[spr_chechRangeDateMaliyat](@fldFromDate nvarchar(10),@FldEndDate nvarchar(10))
as 
IF EXISTS (SELECT * FROM com.tblMaliyatArzesheAfzoode 
WHERE fldFromDate BETWEEN @fldFromDate AND @FldEndDate
OR fldEndDate BETWEEN @fldFromDate AND @FldEndDate
OR @fldFromDate BETWEEN fldFromDate AND fldEndDate
OR @FldEndDate BETWEEN fldFromDate AND fldEndDate)

SELECT TOP(1) ISNULL(fldid,0)fldid  FROM com.tblMaliyatArzesheAfzoode 
WHERE fldFromDate BETWEEN @fldFromDate AND @FldEndDate
OR fldEndDate BETWEEN @fldFromDate AND @FldEndDate
OR @fldFromDate BETWEEN fldFromDate AND fldEndDate
OR @FldEndDate BETWEEN fldFromDate AND fldEndDate
ORDER BY fldid DESC
ELSE 
SELECT 0 AS fldid



GO
