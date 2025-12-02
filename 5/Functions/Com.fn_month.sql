SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_month](@code as tinyint)
RETURNS nvarchar(30)
AS
BEGIN
declare @name as nvarchar(30)
set @name=case @code
	when 1 then N'فروردین'
	when 2 then N'اردیبهشت'
	when 3 then N'خرداد'
	when 4 then N'تیر'
	when 5 then N'مرداد'
	when 6 then N'شهریور'
	when 7 then N'مهر'
	when 8 then N'آبان'
	when 9 then N'آذر'
	when 10 then N'دی'
	when 11 then N'بهمن'
	when 12 then N'اسفند'
	end
return @name
END
GO
