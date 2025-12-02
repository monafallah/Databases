SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_DetailsDelete] 
@fldID int,
@fldUserID int
AS 

	
	
	BEGIN TRAN
	UPDATE [BUD].[tblCodingBudje_Details]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  fldCodeingBudjeId = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [BUD].[tblCodingBudje_Details]
	WHERE  fldCodeingBudjeId = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
