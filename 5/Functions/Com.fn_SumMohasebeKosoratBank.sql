SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_SumMohasebeKosoratBank](@MohsebeId INT)
RETURNS INT

AS
BEGIN
DECLARE @sum INT=0
SELECT @sum=SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank
WHERE fldMohasebatId=@MohsebeId

RETURN ISNULL(@sum,0)
end
GO
