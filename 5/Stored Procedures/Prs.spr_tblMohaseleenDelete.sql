SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMohaseleenDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Prs].[tblMohaseleen]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Prs].[tblMohaseleen]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
