SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	DECLARE @fldUserId int 
	SELECT @fldUserID=fldUserid FROM dbo.tblInputInfo WHERE fldid=@fldInputID
	UPDATE dbo.tblTicket
	SET fldUserId=@fldUserId,fldInputID=@fldInputID,fldDate=GETDATE()
	WHERE fldid=@fldId
	
	DELETE
	FROM   [dbo].[tblTicket]
	WHERE  fldId = @fldId

	COMMIT
GO
