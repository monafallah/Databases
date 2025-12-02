SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[fn_GetPreviousMonth] (@Year smallint=1400,@Month tinyint=1)
returns int
begin
	declare @YearP SMALLINT=@Year,@MonthP TINYINT=@Month-1

	if(@Month=1)
	begin
		set @YearP=@Year-1
		set @MonthP=12
	end

	return @YearP*100+@MonthP
end
GO
