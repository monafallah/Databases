SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserGroupDelete] 
	@fldUserGroupId int,
	@fldInputId int
AS 
	BEGIN TRAN
	
	
	
	DELETE
	FROM   [dbo].[tblTimeLimit_UserGroup]
	WHERE  fldUserGroupId = @fldUserGroupId
	if (@@ERROR<>0)
		ROLLBACK
	
	COMMIT
GO
