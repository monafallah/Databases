SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[IsValidIranianIBAN](@IBAN NVARCHAR(26))
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0;
    DECLARE @CleanIBAN NVARCHAR(26);
    DECLARE @CheckDigits NVARCHAR(2);
    DECLARE @BankCode NVARCHAR(3);
    DECLARE @AccountNumber NVARCHAR(26);
    DECLARE @RearrangedIBAN NVARCHAR(30);
    DECLARE @NumericString NVARCHAR(30);
    DECLARE @Remainder INT;
    DECLARE @i INT;
    DECLARE @CurrentChar CHAR(1);
    
    -- حذف فاصله‌ها و تبديل به حروف بزرگ
    SET @CleanIBAN = UPPER(REPLACE(@IBAN, ' ', ''));
    
    -- بررسي طول شبا (بايد 26 کاراکتر باشد)
    IF LEN(@CleanIBAN) != 26
        RETURN 0;
    
    -- بررسي شروع با IR
    IF LEFT(@CleanIBAN, 2) != 'IR'
        RETURN 0;
    
    -- استخراج اجزاي شبا
    SET @CheckDigits = SUBSTRING(@CleanIBAN, 3, 2);
    SET @BankCode = SUBSTRING(@CleanIBAN, 5, 3);
    SET @AccountNumber = SUBSTRING(@CleanIBAN, 8, 25);
    
    -- بررسي اينکه کد بانک و شماره حساب عددي باشند
    IF ISNUMERIC(@CheckDigits) = 0 OR ISNUMERIC(@BankCode) = 0 OR ISNUMERIC(@AccountNumber) = 0
        RETURN 0;
    
    -- بررسي کدهاي بانک‌هاي معتبر ايراني
    IF @BankCode NOT IN ('011', '012', '013', '014', '015', '016', '017', '018', '019', '020',
                         '021', '022', '054', '055', '056', '057', '058', '059', '060', '061',
                         '062', '063', '064', '065', '066', '069', '070', '073', '075', '078',
                         '080', '087', '088', '089', '090', '095', '096')
        RETURN 0;
    
    -- ايجاد رشته براي محاسبه چک ديجيت (حروف IR را به انتها منتقل مي‌کنيم)
    SET @RearrangedIBAN = @BankCode + @AccountNumber + '1827' + @CheckDigits; -- IR = 1827
    
    -- محاسبه باقيمانده با استفاده از الگوريتم MOD 97
    SET @Remainder = 0;
    SET @i = 1;
    
    WHILE @i <= LEN(@RearrangedIBAN)
    BEGIN
        SET @CurrentChar = SUBSTRING(@RearrangedIBAN, @i, 1);
        SET @Remainder = (@Remainder * 10 + CAST(@CurrentChar AS INT)) % 97;
        SET @i = @i + 1;
    END
    
    -- اگر باقيمانده 1 باشد، شبا معتبر است
    IF @Remainder = 1
        SET @IsValid = 1;
    
    RETURN @IsValid;
END
GO
