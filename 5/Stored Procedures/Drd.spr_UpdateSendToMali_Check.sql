SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_UpdateSendToMali_Check] 
	@fldID int,
    @fldStatus bit
AS 
	
	BEGIN TRAN
	update drd.tblCheck set fldSendToMali=@fldStatus,fldSendToMaliDate=dbo.Fn_AssembelyMiladiToShamsi(getdate()) where fldid=@fldID

	COMMIT
GO
