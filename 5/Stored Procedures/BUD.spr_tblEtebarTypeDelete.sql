SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblEtebarTypeDelete] 
    @fldId INT,
    @fldUserId int
AS 
	
	
	BEGIN TRAN
	
	UPDATE BUD.tblEtebarType
	SET fldUserId=@fldUserId,fldDate=GETDATE()
	WHERE fldId =@fldId 

	DELETE
	FROM   [BUD].[tblEtebarType]
	WHERE  [fldId] = @fldId


if (@@ERROR<>0)
		ROLLBACK
	COMMIT
GO
