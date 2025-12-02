SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_DetailsDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	
	DELETE
	FROM   [ACC].[tblBankBill_Details]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
