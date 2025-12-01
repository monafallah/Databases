SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[Is_EnLeapYear](@EnYear SMALLINT) RETURNS BIT
BEGIN 
  DECLARE @Result BIT 
  IF ((@EnYear % 4) = 0) AND (((@EnYear % 100) <> 0) OR ((@EnYear % 400) = 0))
    SET @Result = 1
  ELSE 
    SET @Result = 0
  RETURN @Result
END
GO
