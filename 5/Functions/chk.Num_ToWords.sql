SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE FUNCTION [chk].[Num_ToWords] (
 
    @Number Numeric (38, 0) -- Input number with as many as 18 digits
 
) RETURNS NVARCHAR(4000)
 
AS BEGIN

DECLARE @inputNumber VARCHAR(38)
DECLARE @NumbersTable TABLE (number int, word NVARCHAR(10))
DECLARE @outputString NVARCHAR(4000)
DECLARE @length INT
DECLARE @counter INT
DECLARE @loops INT
DECLARE @position INT
DECLARE @chunk CHAR(3)
DECLARE @tensones CHAR(2)
DECLARE @hundreds CHAR(1)
DECLARE @tens CHAR(1)
DECLARE @ones CHAR(1)
DECLARE @And nvarchar(3)
DECLARE @Neg nvarchar(10)
 
    IF @Number = 0 return N'صفر'
     
    IF  Left(@Number ,1) <> N'-'
        SET  @Neg = N' '
    ELSE
    BEGIN
        SET  @Neg = N'منفی '
        SET  @Number = @Number * -1
    END
 
SELECT @inputNumber = CONVERT(varchar(38), @Number)
     , @outputString = N''
     , @counter = 1
SELECT @length   = LEN(@inputNumber)
     , @position = LEN(@inputNumber) - 2
     , @loops    = LEN(@inputNumber)/3
 
 
IF LEN(@inputNumber) % 3 <> 0 SET @loops = @loops + 1
 
 
INSERT INTO @NumbersTable   SELECT 0, N''
    UNION ALL SELECT 1, N' یک '      UNION ALL SELECT 2, N' دو '
    UNION ALL SELECT 3, N' سه '    UNION ALL SELECT 4, N' چهار '
    UNION ALL SELECT 5, N' پنج '     UNION ALL SELECT 6, N' شش '
    UNION ALL SELECT 7, N' هفت '    UNION ALL SELECT 8, N' هشت '
    UNION ALL SELECT 9, N' نه '     UNION ALL SELECT 10, N' ده '
    UNION ALL SELECT 11, N' یازده '   UNION ALL SELECT 12, N' دوازده '
    UNION ALL SELECT 13, N' سیزده ' UNION ALL SELECT 14, N' چهارده '
    UNION ALL SELECT 15, N' پانزده '  UNION ALL SELECT 16, N' شانزده '
    UNION ALL SELECT 17, N' هفده ' UNION ALL SELECT 18, N' هیجده '
    UNION ALL SELECT 19, N' نوزده ' UNION ALL SELECT 20, N' بیست '
    UNION ALL SELECT 30, N' سی '   UNION ALL SELECT 40, N' چهل '
    UNION ALL SELECT 50, N' پنجاه '    UNION ALL SELECT 60, N' شصت '
    UNION ALL SELECT 70, N' هفتاد '  UNION ALL SELECT 80, N' هشتاد '
    UNION ALL SELECT 90, N' نود '   UNION ALL SELECT 100, N' صد '
    UNION ALL SELECT 200, N' دویست '   UNION ALL SELECT 300, N' سیصد '
    UNION ALL SELECT 400, N' چهارصد '   UNION ALL SELECT 500, N' پانصد '
    UNION ALL SELECT 600, N' ششصد '   UNION ALL SELECT 700, N' هفتصد '
    UNION ALL SELECT 800, N' هشتصد '   UNION ALL SELECT 900, N' نهصد '
 
 
WHILE @counter <= @loops BEGIN
 
    SET @chunk = RIGHT('000' + SUBSTRING(@inputNumber, @position, 3), 3)
     
 
    IF @chunk <> '000' BEGIN
        SELECT @tensones = SUBSTRING(@chunk, 2, 2)
             , @hundreds = SUBSTRING(@chunk, 1, 1)
             , @tens = SUBSTRING(@chunk, 2, 1)
             , @ones = SUBSTRING(@chunk, 3, 1)
 
        IF CONVERT(INT, @tensones) <= 20 OR @Ones='0' BEGIN
                if len(@outputString)>0
                    begin
                    set @And=N'و '
                    end
                else
                    begin
                    set @And=''
                    end
                     
                SET @outputString = (SELECT word
                                    FROM @NumbersTable
                                    WHERE @hundreds+'00'  = number)
                            + case @hundreds when '0' then '' else 
                                case @tensones when '00' then '' else N'و' end  end+
                            (
                                    SELECT word
                                      FROM @NumbersTable
                                      WHERE @tensones = number)
                   + CASE @counter WHEN 1 THEN '' -- No name
                       WHEN 2 THEN N' هزار ' WHEN 3 THEN N' میلیون '
                       WHEN 4 THEN N' میلیارد '  WHEN 5 THEN N' بیلیون '
                       WHEN 6 THEN N' بیلیارد ' WHEN 7 THEN N' کوانتیلیون '
                       WHEN 8 THEN N' سکستیلیون '  WHEN 9 THEN N' سپتیلیون '
                       WHEN 10 THEN N' اکتیلیون '  WHEN 11 THEN N' نونیلیون '
                       WHEN 12 THEN N' دسیلیون '  WHEN 13 THEN N' اندسیلیون '
                       ELSE '' END
                               + @And + @outputString
            END
 
         ELSE BEGIN
 
                    if len(@outputString)>0
                    begin
                    set @And=N'و '
                    end
                else
                    begin
                    set @And=''
                    end
                     
                 
 
                SET @outputString = ' '
                            + (SELECT word
                                    FROM @NumbersTable
                                    WHERE @hundreds+'00'  = number)
                             + case @hundreds when '0' then '' else  N'و' end
                            + (SELECT word
                                    FROM @NumbersTable
                                    WHERE   @tens+'0'  = number)
                             + N'و'
                             + (SELECT word
                                    FROM @NumbersTable
                                    WHERE  @ones = number)
                   + CASE @counter WHEN 1 THEN '' -- No name
                       WHEN 2 THEN N' هزار ' WHEN 3 THEN N' میلیون '
                       WHEN 4 THEN N' میلیارد '  WHEN 5 THEN N' بیلیون '
                       WHEN 6 THEN N' بیلیارد ' WHEN 7 THEN N' کوانتیلیون '
                       WHEN 8 THEN N' سکستیلیون '  WHEN 9 THEN N' سپتیلیون '
                       WHEN 10 THEN N' اکتیلیون '  WHEN 11 THEN N' نونیلیون '
                       WHEN 12 THEN N' دسیلیون '  WHEN 13 THEN N' اندسیلیون '
                       ELSE '' END
                            + @And + @outputString
        END
         
 
    END
 
    SELECT @counter = @counter + 1
         , @position = @position - 3
 
END
 
SET @outputString = LTRIM(RTRIM(REPLACE(@outputString, '  ', ' ')))
SET @outputstring = UPPER(LEFT(@outputstring, 1)) + SUBSTRING(@outputstring, 2, 8000)
SET @outputstring = @Neg + @outputstring
SET @outputstring = @outputstring +N' ریال'
 
RETURN @outputString
END
GO
