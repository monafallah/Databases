SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGhabrInfoDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Dead].[tblGhabrInfo]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Dead].[tblGhabrInfo]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
