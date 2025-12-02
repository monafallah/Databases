SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[fn_SharheCode_ElamAvarez](@fldElamAvarezId INT)
RETURNS NVARCHAR(max)
AS
BEGIN
DECLARE @fldSharheCodeDaramad NVARCHAR(max)='',@a INT
SELECT @fldSharheCodeDaramad=fldSharheCodeDaramad+'/'+@fldSharheCodeDaramad FROM Drd.tblCodhayeDaramadiElamAvarez
WHERE fldElamAvarezId=@fldElamAvarezId
--SELECT @fldSharheCodeDaramad
IF(@fldSharheCodeDaramad <>'')BEGIN
SELECT @a=LEN(@fldSharheCodeDaramad)-1
SELECT @fldSharheCodeDaramad=SUBSTRING(@fldSharheCodeDaramad,1,LEN(@fldSharheCodeDaramad)-1)
END
--SELECT @fldSharheCodeDaramad
RETURN @fldSharheCodeDaramad
end
GO
