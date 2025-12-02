SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCodingDetail_CaseTypeDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [ACC].[tblCodingDetail_CaseType]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldCodingDetailId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [ACC].[tblCodingDetail_CaseType]
	WHERE  [fldCodingDetailId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
