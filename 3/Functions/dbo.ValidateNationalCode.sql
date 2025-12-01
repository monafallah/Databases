SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ValidateNationalCode] (@NationalCode CHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0
    DECLARE @Sum INT = 0
    DECLARE @i INT = 0
    DECLARE @CheckDigit INT
    DECLARE @Remainder INT

    -- بررسی طول کد ملی (باید 10 رقم باشد)
    IF LEN(@NationalCode) <> 10 OR @NationalCode NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        RETURN 0

    -- بررسی غیرتکراری بودن ارقام (مثل 1111111111)
    IF @NationalCode IN ('0000000000', '1111111111', '2222222222', '3333333333', '4444444444', 
                         '5555555555', '6666666666', '7777777777', '8888888888', '9999999999')
        RETURN 0

    -- محاسبه مجموع وزن‌دار ارقام
    SET @i = 1
    WHILE @i <= 9
    BEGIN
        SET @Sum = @Sum + CAST(SUBSTRING(@NationalCode, @i, 1) AS INT) * (11 - @i)
        SET @i = @i + 1
    END

    -- محاسبه باقی‌مانده
    SET @Remainder = @Sum % 11

    -- بررسی رقم کنترلی
    SET @CheckDigit = CAST(SUBSTRING(@NationalCode, 10, 1) AS INT)
    IF (@Remainder < 2 AND @CheckDigit = @Remainder) OR (@Remainder >= 2 AND @CheckDigit = 11 - @Remainder)
        SET @IsValid = 1

    RETURN @IsValid
END
GO
