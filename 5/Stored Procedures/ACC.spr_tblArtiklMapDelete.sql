SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblArtiklMapDelete] 
    @fldId int,
	@flduserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [ACC].[tblArtiklMap]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [ACC].[tblArtiklMap]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
