SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[IsValidIranianMobile](@Mobile VARCHAR(15))
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 0
    
    
    
    -- بررسی طول شماره (12 رقم برای 989... یا 11 رقم برای 09...)
    IF LEN(@Mobile) NOT IN (10, 11,12)
        RETURN 0;
    
    -- تبدیل به فرمت 989...
    IF LEN(@Mobile) = 10 AND @Mobile LIKE '9%'
        SET @Mobile = '98' + @Mobile;
    ELSE IF LEN(@Mobile) = 11 AND @Mobile LIKE '09%'
        SET @Mobile = '98' + SUBSTRING(@Mobile, 2, 10);
    
    -- بررسی پیشوند ایران
    IF LEFT(@Mobile, 3) <> '989'
        RETURN 0;
    
    -- بررسی صحت شماره موبایل
    IF @Mobile LIKE '989[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        SET @Result = 1;

    RETURN @Result;
END
GO
