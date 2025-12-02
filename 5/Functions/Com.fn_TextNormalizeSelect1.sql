SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_TextNormalizeSelect1](@text nvarchar(max))
--RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
RETURNS nvarchar(max)
AS
BEGIN 
--EXTERNAL NAME [NormalizeDll].[ssText].[ssTextNormalize]
            DECLARE @strright nvarchar(max),@strleft nvarchar(max),@a NVARCHAR(max),@i INT,@len INT,@newtext nvarchar(max),@strtext nvarchar(max)
            SET @strtext=@text
            SET @newtext=''
            SET @strright= N'ـچجحخهعغفقثصضشپگکمنتلبكیسشظطئي'
            SET @strleft = N'ژیچيجحخهعغفقثصضشپگكکمنتلبیسشظطئودذرزژاةآۀـ‍'
            SET @a = LTRIM(RTRIM(@strtext))
            SET @a = REPLACE(@a,N'ي',N'ی')
            SET @a = REPLACE(@a,N'ك',N'ک')
            SET @len=(LEN(@a))

            WHILE(@a like N'%  %')
            BEGIN
            
                SET @a = REPLACE(@a,'  ', ' ')

            END
            SET @i=1
            SET @len=(len(@a))
            WHILE(@i<=@len)
            BEGIN
                IF (SUBSTRING(@a,@i , 1) = ' ')
                  BEGIN
                  IF (@strright LIKE N'%'+SUBSTRING(@a,@i- 1, 1)+'%' and @strleft LIKE N'%'+SUBSTRING(@a,@i+ 1, 1)+'%')
                    BEGIN
                       SET @newtext=@newtext+SUBSTRING(@a,@i , 1)
                    END
                  END
                ELSE
                  BEGIN
                    SET @newtext=@newtext+SUBSTRING(@a,@i , 1)
                  END
                SET @i=@i+1
           END
         SET @newtext = LTRIM(RTRIM(@newtext))
         
	RETURN @newtext
END
GO
