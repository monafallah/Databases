SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_ShamsiDateStrDiffDay] (@FDate varchar(10), @LDate varchar(10)) 
RETURNS int 
AS 
BEGIN 
declare @FY int, @FM int, @FD int, @LY int, @LM int, @LD int,
@FirstM int, @FirstD int, @LastM int, @LastD int,
@YDiff int, @LDiff int, @FDiff int
set @FY = dbo.fn_ShamsiDateStrPart(@FDate, 'Y')
set @FM = dbo.fn_ShamsiDateStrPart(@FDate, 'M')
set @FD = dbo.fn_ShamsiDateStrPart(@FDate, 'D')
set @LastM = 12
set @LastD = 30
set @LDiff = ((@LastM - @FM) * 30) + (@LastD - @FD) 
set @LY = dbo.fn_ShamsiDateStrPart(@LDate, 'Y')
set @LM = dbo.fn_ShamsiDateStrPart(@LDate, 'M')
set @LD = dbo.fn_ShamsiDateStrPart(@LDate, 'D')
set @FirstM = 1
set @FirstD = 1
set @FDiff = ((@LM - @FirstM) * 30) + (@LD - @FirstD)+1
set @YDiff = (@LY - (@FY + 1)) * 360;
return @LDiff + @FDiff + @YDiff
END

GO
