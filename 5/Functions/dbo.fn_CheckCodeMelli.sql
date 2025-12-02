SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_CheckCodeMelli](@CodeMelli NVARCHAR(10))
RETURNS bit
AS
BEGIN
DECLARE @ErrorMessage BIT
	,@C INT
	,@N INT
	,@R INT


IF (
	LEN(@CodeMelli)> 10 OR LEN(@CodeMelli)<10
	OR @CodeMelli = '0000000000'
	OR @CodeMelli = '1111111111'
	OR @CodeMelli = '2222222222'
	OR @CodeMelli = '3333333333'
	OR @CodeMelli = '4444444444'
	OR @CodeMelli = '5555555555'
	OR @CodeMelli = '6666666666'
	OR @CodeMelli = '7777777777'
	OR @CodeMelli = '8888888888'
	OR @CodeMelli = '9999999999'
	)
BEGIN
	SET @ErrorMessage = 0
END
ELSE
BEGIN

	SET @C = cast(SUBSTRING(@CodeMelli, 10, 1) as int)

	SET @N = (cast(SUBSTRING(@CodeMelli, 1, 1) as int) * 10) +
		(cast(SUBSTRING(@CodeMelli, 2, 1) as int) * 9) +
		(cast(SUBSTRING(@CodeMelli, 3, 1) as int) * 8) +
		(cast(SUBSTRING(@CodeMelli, 4, 1) as int) * 7) +
		(cast(SUBSTRING(@CodeMelli, 5, 1) as int) * 6) +
		(cast(SUBSTRING(@CodeMelli, 6, 1) as int) * 5) +
		(cast(SUBSTRING(@CodeMelli, 7, 1) as int) * 4) +
		(cast(SUBSTRING(@CodeMelli, 8, 1) as int) * 3) +
		(cast(SUBSTRING(@CodeMelli, 9, 1) as int) * 2)

	SET @R = @N % 11
	
	IF ((@R = 0 AND @R = @C) OR (@R = 1 AND @C = 1) OR (@R > 1 AND @C = 11 - @R))
		SET @ErrorMessage = 1
	ELSE
		SET @ErrorMessage = 0
END

RETURN @ErrorMessage

END
GO
