SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[DateShamsiFormat] ( @intDate DATETIME, @Format NVARCHAR(max)) 
RETURNS NVARCHAR(max)
BEGIN
/* Format Rules: (پنجشنبه 7 اردیبهشت 1394)
ChandShanbe -> پنجشنبه (روز هفته به حروف)
ChandShanbeAdadi -> 6 (روز هفته به عدد)
Rooz -> 7 (چندمین روز از ماه)
Rooz2 -> 07 (چندمین روز از ماه دو کاراکتری)
Maah -> 2 (چندمین ماه از سال)
Maah2 -> 02 (چندمین ماه از سال دو کاراکتری)
MaahHarfi -> اردیبهشت (نام ماه به حروف)
Saal -> 1394 (سال چهار کاراکتری)
Saal2 -> 94 (سال دو کاراکتری)
Saal4 -> 1394 (سال چهار کاراکتری)
SaalRooz -> 38 (چندمین روز سال)
Default Format -> "ChandShanbe Rooz MaahHarfi Saal"
*/
DECLARE @shYear AS INT ,@shMonth AS INT ,@shDay AS INT ,@intYY AS INT ,@intMM AS INT ,@intDD AS INT ,@Kabiseh1 AS INT ,@Kabiseh2 AS INT ,@d1 AS INT ,@m1 AS INT, @shMaah AS NVARCHAR(max),@shRooz AS NVARCHAR(max),@DayCnt AS INT, @YearDay AS INT
DECLARE @DayDate AS NVARCHAR(max)

SET @intYY = DATEPART(yyyy, @intDate)

IF @intYY < 1000 SET @intYY = @intYY + 2000

SET @intMM = MONTH(@intDate)
SET @intDD = DAY(@intDate)
SET @shYear = @intYY - 622
IF (@Format IS NULL) OR NOT LEN(@Format)>0 SET @Format = 'ChandShanbe Rooz MaahHarfi Saal'

SET @m1 = 1
SET @d1 = 1
SET @shMonth = 10
SET @shDay = 11
SET @DayCnt = datepart(dw, '01/02/' + CONVERT(CHAR(4), @intYY))
SET @YearDay = 276

IF ( ( @intYY - 1993 ) % 4 = 0 ) SET @shDay = 12
SET @YearDay = @YearDay + @shDay

WHILE ( @m1 != @intMM ) OR ( @d1 != @intDD )
BEGIN

 SET @d1 = @d1 + 1
 SET @DayCnt = @DayCnt + 1

 IF ( ( @intYY - 1992 ) % 4 = 0) SET @Kabiseh1 = 1 ELSE SET @Kabiseh1 = 0

 IF ( ( @shYear - 1371 ) % 4 = 0) SET @Kabiseh2 = 1 ELSE SET @Kabiseh2 = 0

 IF 
 (@d1 = 32 AND (@m1 = 1 OR @m1 = 3 OR @m1 = 5 OR @m1 = 7 OR @m1 = 8 OR @m1 = 10 OR @m1 = 12))
 OR
 (@d1 = 31 AND (@m1 = 4 OR @m1 = 6 OR @m1 = 9 OR @m1 = 11))
 OR
 (@d1 = 30 AND @m1 = 2 AND @Kabiseh1 = 1)
 OR
 (@d1 = 29 AND @m1 = 2 AND @Kabiseh1 = 0)
 BEGIN
  SET @m1 = @m1 + 1
  SET @d1 = 1
 END

 IF @m1 > 12
 BEGIN
  SET @intYY = @intYY + 1
  SET @m1 = 1
 END
 
 IF @DayCnt > 7 SET @DayCnt = 1

SET @shDay = @shDay + 1
SET @YearDay = @YearDay + 1
 
 IF
 (@shDay = 32 AND @shMonth < 7)
 OR
 (@shDay = 31 AND @shMonth > 6 AND @shMonth < 12)
 OR
 (@shDay = 31 AND @shMonth = 12 AND @Kabiseh2 = 1)
 OR
 (@shDay = 30 AND @shMonth = 12 AND @Kabiseh2 = 0)
 BEGIN
  SET @shMonth = @shMonth + 1
  SET @shDay = 1
 END

 IF @shMonth > 12
 BEGIN
  SET @shYear = @shYear + 1
  SET @shMonth = 1
  SET @YearDay = 1
 END
 
END

IF @shMonth=1 SET @shMaah=N'فروردین'
IF @shMonth=2 SET @shMaah=N'اردیبهشت'
IF @shMonth=3 SET @shMaah=N'خرداد'
IF @shMonth=4 SET @shMaah=N'تیر'
IF @shMonth=5 SET @shMaah=N'مرداد'
IF @shMonth=6 SET @shMaah=N'شهریور'
IF @shMonth=7 SET @shMaah=N'مهر'
IF @shMonth=8 SET @shMaah=N'آبان'
IF @shMonth=9 SET @shMaah=N'آذر'
IF @shMonth=10 SET @shMaah=N'دی'
IF @shMonth=11 SET @shMaah=N'بهمن'
IF @shMonth=12 SET @shMaah=N'اسفند'

IF @DayCnt=1 SET @shRooz=N'شنبه'
IF @DayCnt=2 SET @shRooz=N'یکشنبه'
IF @DayCnt=3 SET @shRooz=N'دوشنبه'
IF @DayCnt=4 SET @shRooz=N'سه شنبه'
IF @DayCnt=5 SET @shRooz=N'چهارشنبه'
IF @DayCnt=6 SET @shRooz=N'پنجشنبه'
IF @DayCnt=7 SET @shRooz=N'جمعه'

SET @DayDate = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Format,'MaahHarfi',@shMaah),'SaalRooz',LTRIM(STR(@YearDay,3))),'ChandShanbeAdadi',@DayCnt),'ChandShanbe',@shRooz),'Rooz2',REPLACE(STR(@shDay,2), ' ', '0')),'Maah2',REPLACE(STR(@shMonth, 2), ' ', '0')),'Saal2',SUBSTRING(STR(@shYear,4),3,2)),'Saal4',STR(@shYear,4)),'Saal',LTRIM(STR(@shYear,4))),'Maah',LTRIM(STR(@shMonth,2))),'Rooz',LTRIM(STR(@shDay,2)))
/* Format Samples:
Format="ChandShanbe Rooz MaahHarfi Saal" -> پنجشنبه 17 اردیبهشت 1394
Format="Rooz MaahHarfi Saal" -> ـ 17 اردیبهشت 1394
Format="Rooz/Maah/Saal" -> 1394/2/17
Format="Rooz2/Maah2/Saal2" -> 94/02/17
Format="Rooz روز گذشته از MaahHarfi در سال Saal2" -> ـ 17 روز گذشته از اردیبهشت در سال 94
*/
RETURN @DayDate
END
GO
