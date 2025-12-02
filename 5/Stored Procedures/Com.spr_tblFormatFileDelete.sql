SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Com].[spr_tblFormatFileDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update   [com].[tblFormatFile]
	set fldUserId=@fldUserID,fldDate=getdate()
	where fldId = @fldId
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [com].[tblFormatFile]
	WHERE  fldId = @fldId
	if (@@error<>0)
	rollback
	end
	COMMIT
GO
