SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MaxTypeEstekhdam](@PersonalId INT)
RETURNS INT
AS
BEGIN
DECLARE @Id INT,@prs_Personalid INT
SELECT @prs_Personalid=fldPrs_PersonalInfoId FROM Pay.Pay_tblPersonalInfo WHERE fldid=@PersonalId
SELECT     TOP (1) @Id=Com.tblAnvaEstekhdam.fldNoeEstekhdamId 
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId 
                      WHERE  Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId=@prs_Personalid
 
 RETURN @Id
 END
GO
