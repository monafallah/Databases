SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_Maxbime](@Afrad as tinyint)
RETURNS nvarchar(30)
AS
BEGIN
declare @name as nvarchar(20)
set @name=case @Afrad 
	when 1 then N'یک'
	when 2 then N'دو'
	when 3 then N'سه'
	when 4 then N'چهار'
	when 5 then N'پنج'
	when 6 then N'شش'
	
	end
return @name
END
GO
