SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_SumMoavaghatItem](@MoavaghatId  INT)  
RETURNS INT

AS
BEGIN
DECLARE @sum INT=0
SELECT   @sum=  SUM(Pay.tblMoavaghat_Items.fldMablagh)
               from       Pay.tblMoavaghat_Items 
                      WHERE fldMoavaghatId=@MoavaghatId 
 
 RETURN ISNULL(@sum,0)
 END
GO
