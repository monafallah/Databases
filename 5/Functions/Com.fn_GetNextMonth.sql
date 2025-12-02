SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fn_GetNextMonth] (@Year smallint=1400,@Month tinyint=1)
returns tinyint
begin
	declare @YearN SMALLINT=@Year,@MonthN TINYINT=@Month+1

	if(@Month=12)
	begin
		set @YearN=@Year+1
		set @MonthN=1
	end

	return @MonthN
end
GO
