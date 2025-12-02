SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankTemplate_HeaderDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [ACC].[tblBankTemplate_Header]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [ACC].[tblBankTemplate_Details]
	WHERE  fldHeaderId = @fldId
	if (@@error<>0)
		rollback
	else
	begin
		DELETE
		FROM   [ACC].[tblBankTemplate_Header]
		WHERE  [fldId] = @fldId
		if (@@error<>0)
			rollback
	end
	COMMIT
GO
