SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- تابع کمکي براي فرمت کردن شماره شبا
CREATE FUNCTION [dbo].[FormatIBAN](@IBAN NVARCHAR(26))
RETURNS NVARCHAR(32)
AS
BEGIN
    DECLARE @CleanIBAN NVARCHAR(26);
    DECLARE @FormattedIBAN NVARCHAR(32);
    
    SET @CleanIBAN = UPPER(REPLACE(@IBAN, ' ', ''));
    
    -- فرمت: IR00 0000 0000 0000 0000 0000 00
    SET @FormattedIBAN = 
        SUBSTRING(@CleanIBAN, 1, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 5, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 9, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 13, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 17, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 21, 4) + ' ' +
        SUBSTRING(@CleanIBAN, 25, 2);
    
    RETURN @FormattedIBAN;
END
GO
