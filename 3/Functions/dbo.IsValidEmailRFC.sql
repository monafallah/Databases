SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[IsValidEmailRFC] (@Email VARCHAR(255))
RETURNS BIT
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @IsValid BIT = 0;
    
    -- بررسی طول ایمیل
    IF LEN(@Email) > 254 OR LEN(@Email) < 5 
        RETURN 0;
    
    -- بررسی ساختار کلی
    IF @Email NOT LIKE '_%@_%._%' 
        RETURN 0;
    
    -- بررسی کاراکترهای غیرمجاز
    IF @Email LIKE '%["(),:;<>[\] ]%' 
        OR @Email LIKE '%@%@%' 
        OR @Email LIKE '%..%'
        OR @Email LIKE '%.@%'
        OR @Email LIKE '%@.'
        OR @Email LIKE '%.'
        RETURN 0;
    
    -- بررسی دامنه (بعد از @)
    DECLARE @DomainPart VARCHAR(255) = SUBSTRING(@Email, CHARINDEX('@', @Email) + 1, LEN(@Email));
    
    IF @DomainPart NOT LIKE '_%._%' 
        OR @DomainPart LIKE '%[^a-zA-Z0-9.-]%'
        OR @DomainPart LIKE '%-%' 
        AND (@DomainPart LIKE '-%' OR @DomainPart LIKE '%-')
        RETURN 0;
    
    -- بررسی TLD (پسوند دامنه)
    DECLARE @LastDotPosition INT = LEN(@DomainPart) - CHARINDEX('.', REVERSE(@DomainPart)) + 1;
    DECLARE @TLD VARCHAR(10) = SUBSTRING(@DomainPart, @LastDotPosition + 1, LEN(@DomainPart));
    
    IF LEN(@TLD) < 2 OR @TLD LIKE '%[^a-zA-Z]%'
        RETURN 0;
    
    SET @IsValid = 1;
    RETURN @IsValid;
END
GO
