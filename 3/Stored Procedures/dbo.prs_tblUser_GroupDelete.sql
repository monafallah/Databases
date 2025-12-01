SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_GroupDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	

	DELETE
	FROM   [dbo].[tblUser_Group]
	WHERE  fldUserSelectID = @fldId
	if(@@ERROR<>0)
	
		rollback
	
	
	COMMIT
GO
