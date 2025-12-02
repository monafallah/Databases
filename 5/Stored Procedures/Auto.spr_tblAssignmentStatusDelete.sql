SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblAssignmentStatusDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Auto].[tblAssignmentStatus]
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
