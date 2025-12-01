SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_PermissionDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	
	DELETE
	FROM   [dbo].[tblUser_Permission]
	WHERE  fldUserSelectId = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end

	COMMIT
GO
