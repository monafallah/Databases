SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Prs].[fn_SumItemHokm](@HokmId int)
RETURNS BIGINT
AS
BEGIN
DECLARE @mablagh BIGINT=0
SELECT @mablagh=SUM(fldMablagh) FROM Prs.tblHokm_Item
WHERE fldPersonalHokmId=@HokmId
RETURN @mablagh
end
GO
