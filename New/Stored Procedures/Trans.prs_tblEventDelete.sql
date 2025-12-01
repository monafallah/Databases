SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventDelete] 
	@fldID int

AS 
	BEGIN TRAN
	declare @formulid int
	select @formulid=fldFormulId from Trans.tblEvent where fldId=@fldID

	DELETE
	FROM   [Trans].[tblEvent]
	WHERE  fldId = @fldId
	if(@@ERROR<>0)
	rollback
	else
	begin
		delete from tblComputationFormula
		where fldId=@formulid
		if(@@ERROR<>0)
		rollback
	end
	COMMIT
GO
