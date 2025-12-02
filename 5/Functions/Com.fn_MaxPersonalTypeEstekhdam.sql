SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MaxPersonalTypeEstekhdam]( @PersonalId int)
RETURNs tinyint
AS 
BEGIN
DECLARE @NoeEstekhdamId tinyint=0,@AzTarikh NVARCHAR(10)
SELECT     @AzTarikh= max(fldTarikh)
FROM         Prs.tblHistoryNoeEstekhdam
WHERE fldPrsPersonalInfoId=@PersonalId

SELECT     @NoeEstekhdamId=fldNoeEstekhdamId
FROM         prs.tblHistoryNoeEstekhdam
WHERE fldPrsPersonalInfoId=@PersonalId AND fldTarikh=@AzTarikh
GROUP BY fldNoeEstekhdamId
RETURN @NoeEstekhdamId
end
GO
