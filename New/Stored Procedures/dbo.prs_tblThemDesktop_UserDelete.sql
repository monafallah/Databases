SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblThemDesktop_UserDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	DELETE
	FROM   [dbo].tblThemDesktop_User
	where  fldId =@fldId
	if(@@Error<>0)
        rollback   
	COMMIT
GO
