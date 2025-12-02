SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_PayIdWithEmployeeId] (@Id int)
RETURNS INT
AS
BEGIN
DECLARE @i INT
SELECT  @i=Pay_tblPersonalInfo.fldId      
FROM            Pay.Pay_tblPersonalInfo INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId
						 WHERE fldEmployeeId=@id
RETURN @I
end
GO
