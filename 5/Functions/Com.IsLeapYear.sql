SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[IsLeapYear]
(
    @Year int
)
RETURNS bit
AS
BEGIN
    DECLARE @ResultVar bit

    if @Year % 400 = 0
       Begin
            set @ResultVar=1
       end
    else if @Year % 100 = 0
       Begin
            set @ResultVar=0
       end
    else if @Year % 4 = 0
       Begin
            set @ResultVar=1
       end
    else
       Begin
            set @ResultVar=0
       end

    RETURN @ResultVar

END
GO
