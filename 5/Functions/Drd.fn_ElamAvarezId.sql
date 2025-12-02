SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[fn_ElamAvarezId]( @IdCode INT)
RETURNS INT
AS
BEGIN
DECLARE @ElamAvarezId INT
SELECT @ElamAvarezId=fldElamAvarezId FROM Drd.tblCodhayeDaramadiElamAvarez 
WHERE fldID= @IdCode 
RETURN @ElamAvarezId
END
GO
