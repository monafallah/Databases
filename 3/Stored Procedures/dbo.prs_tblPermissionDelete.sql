SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPermissionDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	
	DELETE
	FROM   [dbo].[tblPermission]
	WHERE  fldUserGroupID = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end
	
	COMMIT
GO
