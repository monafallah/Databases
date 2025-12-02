SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_CheckShomareSheba](@shomare NVARCHAR(27))
RETURNS INT
AS
BEGIN
--DECLARE @shomare NVARCHAR(max)='ir730170000000347339451009'
DECLARE @r NVARCHAR(50)='',@s NVARCHAR(50),@k NVARCHAR(50),@w NVARCHAR(50),@Resulte INT
--IF  (@shomare LIKE '%i%' OR @shomare LIKE '%r%' )
--BEGIN
--SET @shomare=REPLACE(@shomare,'r','R')
--SET @shomare=REPLACE(@shomare,'i','I')
--end
--SELECT LEN(@f)
SET @r=SUBSTRING(@shomare,5,26)
SET @s=SUBSTRING(@shomare,1,4)
SET @k=@r+@s
SET @k=REPLACE(@k,'I',18)

SET  @w=REPLACE(@k,'R',27)
--SELECT @w,@k
SELECT @Resulte=CAST(@w AS DECIMAL(29,0))%97
/*اگر خروجی مساوی 1 باشد شماره شبا صحیح میباشد*/
--SELECT @Resulte
RETURN @Resulte
end
GO
