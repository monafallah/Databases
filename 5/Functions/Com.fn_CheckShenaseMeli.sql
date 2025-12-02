SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_CheckShenaseMeli](@ShenaseMeli NVARCHAR(11) )
RETURNS INT
AS
BEGIN
DECLARE /*@ShenaseMeli NVARCHAR(11)='10862016649',*/@len int,@k INT ,@k1 INT,@k2 INT,@b INT
DECLARE @N1 NVARCHAR(20)='',@N2 NVARCHAR(20)='',@N3 NVARCHAR(20)='',@N4 NVARCHAR(20)='',@N5 NVARCHAR(20)='',@N6 NVARCHAR(20)=''
DECLARE @N7 NVARCHAR(20)='',@N8 NVARCHAR(20)='',@N9 NVARCHAR(20)='',@N10 NVARCHAR(20)='',@resulte INT,@r int
SET @len=CAST(LEN(@ShenaseMeli) AS INT)
--SELECT @len
IF(@len<11 OR (@ShenaseMeli)='00000000000')
set @b=0
IF(CAST(SUBSTRING(@ShenaseMeli,3,6) AS INT)=0)
BEGIN
SET  @b=0
end
SET @k=CAST(SUBSTRING(@ShenaseMeli,11,1)AS INT)
--SELECT @k
SET @k1=cast(SUBSTRING(@ShenaseMeli,10, 1)AS int) + 2
SET @N1=((CAST(SUBSTRING(@ShenaseMeli,1, 1)AS int)+@k1)*29)
SET @N2=((CAST(SUBSTRING(@ShenaseMeli,2, 1)AS int)+@k1)*27)
SET @N3=((CAST(SUBSTRING(@ShenaseMeli,3, 1)AS int)+@k1)*23)
SET @N4=((CAST(SUBSTRING(@ShenaseMeli,4, 1)AS int)+@k1)*19)
SET @N5=((CAST(SUBSTRING(@ShenaseMeli,5, 1)AS int)+@k1)*17)
SET @N6=((CAST(SUBSTRING(@ShenaseMeli,6, 1)AS int)+@k1)*29)
SET @N7=((CAST(SUBSTRING(@ShenaseMeli,7, 1)AS int)+@k1)*27)
SET @N8=((CAST(SUBSTRING(@ShenaseMeli,8, 1)AS INT)+@k1)*23)
SET @N9=((CAST(SUBSTRING(@ShenaseMeli,9, 1)AS int)+@k1)*19)
SET @N10=((CAST(SUBSTRING(@ShenaseMeli,10, 1)AS int)+@k1)*17)
SET @r=CAST(@n1 AS INT)+CAST(@n2 AS INT)+CAST(@n3 AS INT)+CAST(@n4 AS INT)+CAST(@n5 AS INT)
+CAST(@n6 AS INT)+CAST(@n7 AS INT)+CAST(@n8 AS INT)+CAST(@n9 AS INT)+CAST(@n10 AS INT)

SET @resulte=(@r%11)
IF(@resulte=10)
SET @resulte=0
IF(@resulte=@k)
SET @b=1 --معتبر میباشد
ELSE
SET @b=0
RETURN @b
end


GO
