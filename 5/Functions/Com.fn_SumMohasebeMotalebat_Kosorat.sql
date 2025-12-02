SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_SumMohasebeMotalebat_Kosorat](@MohasebeId INT,@Type bit)
RETURNS INT

AS
BEGIN
DECLARE @Sum INT=0

IF(@Type=0)/*مجموع مطالبات*/

SELECT @Sum=SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=@MohasebeId AND fldKosoratId IS NULL 

IF(@Type=1)/*مجموع کسورات*/

SELECT @Sum=SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=@MohasebeId AND fldMotalebatId IS NULL 

RETURN ISNULL(@Sum,0)
END
GO
