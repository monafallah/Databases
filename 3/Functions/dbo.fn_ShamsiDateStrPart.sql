SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_ShamsiDateStrPart] (@ADateStr varchar(10), @ADatePart char)
RETURNS int 
AS 
BEGIN 
declare @FY varchar(4), @FM varchar(2), @FD varchar(2),
@SlashPos1 int, @SlashPos2 int
if @ADateStr = '' return null
set @SlashPos1 = CHARINDEX('/', @ADateStr)
if (@SlashPos1 = 0) or ((@SlashPos1 <> 3) and (@SlashPos1 <> 5)) return null
set @SlashPos2 = CHARINDEX('/', @ADateStr, @SlashPos1 + 1)
if @SlashPos2 = 0 return null
set @FY = Cast(SUBSTRING (@ADateStr, 1 , @SlashPos1 - 1 ) as int)
set @FM = Cast(SUBSTRING (@ADateStr, @SlashPos1 + 1, @SlashPos2 - @SlashPos1 - 1) as int)
set @FD = Cast(SUBSTRING (@ADateStr, @SlashPos2 + 1, LEN(@ADateStr) - @SlashPos2) as int)
return 
case @ADatePart
when 'Y' then @FY
when 'M' then @FM
when 'D' then @FD
end
END
GO
