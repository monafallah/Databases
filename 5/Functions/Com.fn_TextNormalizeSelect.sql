SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_TextNormalizeSelect](@text nvarchar(max))
--RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
RETURNS nvarchar(max)
AS
BEGIN 

  DECLARE @strright nvarchar(max),@strleft nvarchar(max),@a NVARCHAR(max),@i INT,@len INT,@newtext nvarchar(max),@strtext nvarchar(max)
            
            SET @newtext=@text            
            SET @newtext = REPLACE(@text,N'ي',N'ی')
            SET @newtext = REPLACE(@newtext,N'ك',N'ک')    
            WHILE(@newtext like N'%  %')
            BEGIN
            
                  SET @newtext = REPLACE(LTRIM(RTRIM(@newtext)), '  ', ' ')

            END       
         
	RETURN @newtext
END
GO
