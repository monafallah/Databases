SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblThemDesktop_UserUpdate] 
    @fldId int,
    @fldFileDesktopId int,
    @fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN

	UPDATE dbo.tblThemDesktop_User
	SET    [fldFileDesktopId] = @fldFileDesktopId, [fldType] = @fldType, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
