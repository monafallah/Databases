SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_SeparateWords](@StringValue nVARCHAR(1000),@Tedad tinyint)
RETURNS nvarchar(500)
AS
begin
DECLARE @StringValue1 nvarchar(1000)='',@max INT
DECLARE @temp TABLE (StringValue NVARCHAR(1000), Word NVARCHAR(500), Position INT, RestOfLine NVARCHAR(1000))
IF(@StringValue<>'')
begin
;WITH SeparateWords ( StringValue, Word, Position, RestOfLine)
AS
       (
	       SELECT  @StringValue
                     , CASE CHARINDEX(' ',@StringValue)
                            WHEN 0 THEN @StringValue
                            ELSE LEFT(@StringValue,  CHARINDEX(' ',@StringValue) -1)

                       END
                     , 1
                     , CASE CHARINDEX(' ',@StringValue)
                           WHEN 0 THEN ''
                           ELSE RIGHT(@StringValue, LEN(@StringValue) - CHARINDEX(' ',@StringValue))
                       END
      	   UNION ALL

           SELECT  sw.StringValue
                     , CASE CHARINDEX(' ',RestOfLine)
                           WHEN 0 THEN RestOfLine
                           ELSE LEFT(RestOfLine, CHARINDEX(' ',RestOfLine) -1)
                       END
                     , Position + 1
                     , CASE CHARINDEX(' ',RestOfLine)
                           WHEN 0 THEN ''
                           ELSE RIGHT(RestOfLine, LEN(RestOfLine) -
									  CHARINDEX(' ',RestOfLine))
                       END
           FROM SeparateWords AS sw
           WHERE sw.RestOfLine != ''
       )
 INSERT INTO @temp
SELECT * FROM SeparateWords OPTION (MAXRECURSION 0)
  
SELECT @StringValue1=@StringValue1+' '+word+'' FROM @temp where Position<=@Tedad 
IF  ((SELECT count (*) FROM @temp) >=@tedad)
set @StringValue1=@StringValue1+'...'
end   
ELSE 
SET @StringValue1=''

RETURN @StringValue1
END


GO
