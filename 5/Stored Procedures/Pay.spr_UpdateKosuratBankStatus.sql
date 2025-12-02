SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_UpdateKosuratBankStatus](@Status BIT,@Id INT,@TarikhDeactive INT,@UserId INT)
as
UPDATE Pay.tblKosuratBank
SET fldStatus=@Status,fldDeactiveDate=@TarikhDeactive,fldUserId=@UserId
WHERE fldId=@Id 
GO
