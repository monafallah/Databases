SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblArchiveDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	update  [Auto].[sp_tblArchiveDelete] 
	set flduserid=@fldUserID,fldDate=getdate()
	where fldid =@fldId
	if (@@error<>0)
	rollback
	else 
	begin
	DELETE
	FROM   [dbo].[tblArchive]
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	COMMIT TRAN

GO
