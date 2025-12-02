SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[fn_GetNextYear] (@Year smallint=1400,@Month tinyint=1)
returns smallint
begin
	declare @YearN SMALLINT=@Year,@MonthN TINYINT=@Month+1

	if(@Month=12)
	begin
		set @YearN=@Year+1
		set @MonthN=1
	end

	return @YearN
end
GO
