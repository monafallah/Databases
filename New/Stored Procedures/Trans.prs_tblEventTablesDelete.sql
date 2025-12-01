SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventTablesDelete] 
	@fldID int
AS 
	BEGIN TRAN
	declare @formulid int
	select @formulid=fldFormulId from Trans.tblEventTables where fldId=@fldID

	DELETE
	FROM   [Trans].[tblEvent]
	WHERE  fldId = @fldId
	if(@@ERROR<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Trans].[tblEventTables]
	WHERE  fldId = @fldId
	if(@@ERROR<>0)
	rollback
	end
	COMMIT
GO
