SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_SumMablaghMoavaghat_Mohasebat_Items](@ItemEstekhdamId INT,@MohasebatId int)
RETURNS INT
AS
BEGIN
DECLARE @sumMoavaghat INT=0,@sumMohasebat INT=0,@re INT=0
SELECT @sumMoavaghat=SUM(fldMablagh)
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId 
                      WHERE fldItemEstekhdamId=@ItemEstekhdamId AND fldMohasebatId=@MohasebatId
                      
SELECT @sumMohasebat=fldMablagh FROM Pay.tblMohasebat_Items
WHERE fldItemEstekhdamId=@ItemEstekhdamId AND fldMohasebatId=@MohasebatId

SET @re=@sumMohasebat+@sumMoavaghat
RETURN ISNULL(@re,0)
END
GO
