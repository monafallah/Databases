SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketPermissionDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	
	
	DELETE
	FROM   [dbo].[tblTicketPermission]
	WHERE  fldTicketUserId = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end

	COMMIT
GO
