SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_DeleteAccountingLevel]
@fldYear SMALLINT,@fldOrganId INT

AS
BEGIN TRAN


DELETE FROM ACC.tblAccountingLevel
WHERE fldYear=@fldYear AND fldOrganId=@fldOrganId

COMMIT 
GO
