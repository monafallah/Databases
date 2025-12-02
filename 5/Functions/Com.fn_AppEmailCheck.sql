SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_AppEmailCheck](@email nVARCHAR(255))   
--Returns true if the string is a valid email address.  
RETURNS bit 
as 
BEGIN 
     DECLARE @valid bit 
     IF @email IS NOT NULL  
		 BEGIN
          SET @email = LOWER(@email)  
          SET @valid = 0  
          END
          IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%' 
             AND LEN(@email) = LEN(com.fn_AppStripNonEmail(@email))  
             AND @email NOT like '%@%@%' 
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z' 
               SET @valid=1  
               
               
     RETURN @valid  
END
GO
