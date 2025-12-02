SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[fn_getdateDeactive](@count INT,@tarikh NVARCHAR(10))
RETURNS CHAR(6)
AS
begin
DECLARE @Sal int = SUBSTRING(@tarikh,1,4)
DECLARE @Mah int= SUBSTRING(@tarikh,6,2)

SET @Mah = @Mah + @count - 1;
            while (@Mah > 12)
            begin
                SET @Sal += 1;
                SET @Mah = @Mah - 12;
            END
RETURN (SELECT CAST(@Sal AS CHAR(4))+''+CASE WHEN @mah<10 THEN +'0'+CAST(@mah AS CHAR(2)) ELSE CAST(@mah AS CHAR(2)) END)
end
GO
