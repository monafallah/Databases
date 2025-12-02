SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[prs_tblMonasebatDelete] 
    @fldId tinyint,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Pay].[tblMonasebat]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Pay].[tblMonasebat]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
