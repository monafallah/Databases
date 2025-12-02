SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fn_stringCode](@a NVARCHAR(max))
RETURNS nvarchar(MAX)
AS
begin
declare @l int,@p int
SET @l=LEN(@a)
DECLARE @k nvarCHAR(max);
DECLARE @s  NVARCHAR(max)='';
DECLARE @i INT=1
WHILE(@i<=@l)
begin
    SET @p= 3 * UNICODE(SUBSTRING(@a,@i,1)) + 1071;
    SET @k = nCHAR(@p);
    SET @s = @s + @k;
    SET @i=@i+1
end
return @s
end
GO
