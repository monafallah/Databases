SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatTarikhDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Pay].[tblMonasebatTarikh]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  fldYear = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Pay].[tblMonasebatTarikh]
	WHERE  fldYear = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
