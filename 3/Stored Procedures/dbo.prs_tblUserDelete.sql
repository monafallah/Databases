SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserDelete] 
	@fldID int,
	@fldUserID int,
	@fldInputID int
AS 
	BEGIN TRAN
	update tblUser set fldUserId=@fldUserID,fldInputID=@fldInputID,fldDate=GETDATE()
	where fldId=@fldID
	DELETE
	FROM   [dbo].[tblUser]
	WHERE  fldId = @fldId

	COMMIT
GO
