SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_DetailDelete] 
    @fldId int,
	@fldUserId int 
AS 
	
	
	BEGIN TRAN
	UPDATE [Drd].[tblMap_Detail]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Drd].[tblMap_Detail]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
