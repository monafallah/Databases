SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_IsMaliyatforMohasebe](@MohasebeId INT )
RETURNS INT
 
AS
BEGIN
DECLARE @Mablagh INT=0,@fldMaliyat INT
SELECT    @Mablagh= fldMablagh
FROM         Pay.tblP_MaliyatManfi
WHERE fldMohasebeId=@MohasebeId

IF(@Mablagh=0)
BEGIN
	SELECT @fldMaliyat=sum(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=@MohasebeId GROUP BY fldMohasebatId
	SET @Mablagh=@fldMaliyat
	--RETURN ISNULL(@fldMaliyat,0)
	
END

RETURN ISNULL(@Mablagh,0)
END
GO
