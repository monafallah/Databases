SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_IsMaliyatManfiForMoavaghe](@MohasebeId INT,@Moavaghe INT )
RETURNS INT
 
AS
BEGIN
DECLARE @Mablagh INT=0,@fldMaliyat INT
SELECT    @Mablagh= fldMablagh
FROM         Pay.tblP_MaliyatManfi
WHERE fldMohasebeId=@MohasebeId

IF(@Mablagh=0)
BEGIN
	SELECT @fldMaliyat=fldMaliyat FROM Pay.tblMoavaghat WHERE fldId=@Moavaghe
	RETURN ISNULL(@fldMaliyat,0)
END

RETURN ISNULL(@Mablagh,0)
END
GO
