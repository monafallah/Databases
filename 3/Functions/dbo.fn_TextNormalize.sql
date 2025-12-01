SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_TextNormalize](@text nvarchar(max))
--RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
RETURNS nvarchar(max)
AS
BEGIN 
set @text=REPLACE(REPLACE(@text, CHAR(13), ''), CHAR(10), '')
  DECLARE @strright nvarchar(max),@strleft nvarchar(max),@a NVARCHAR(max),@i INT,@len INT,@newtext nvarchar(max),@strtext nvarchar(max)
            
            SET @newtext=@text            
            SET @newtext = REPLACE(@text,N'ي',N'ی')
            SET @newtext = REPLACE(@newtext,N'ك',N'ک')   
			--SET @newtext =TRIM(@newtext)
			set @newtext=LTRIM(RTRIM( @newtext))
            WHILE(@newtext like N'%  %') 
			BEGIN
            
                  SET @newtext = REPLACE(@newtext, '  ', ' ')
				 
			end
	RETURN @newtext
END

GO
