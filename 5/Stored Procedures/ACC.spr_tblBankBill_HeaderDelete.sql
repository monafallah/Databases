SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_HeaderDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN

	UPDATE [ACC].[tblBankBill_Header]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback

	DELETE
	FROM   [ACC].[tblBankBill_Details]
	WHERE  [fldHedearId] = @fldId
	if (@@error<>0)
		rollback

	DELETE
	FROM   [ACC].[tblBankBill_Header]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
