SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserGroupUpdate] 
    @fldId int,
    @fldAppId int,
    @fldTimeLimit smallint,
    @fldUserGroupId int,
	@fldInputId int
AS 
	BEGIN TRAN
	UPDATE [dbo].[tblTimeLimit_UserGroup]
	SET    [fldAppId] = @fldAppId, [fldTimeLimit] = @fldTimeLimit, [fldUserGroupId] = @fldUserGroupId
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		
		ROLLBACK
	
	
	COMMIT TRAN
GO
