SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudje_khedmatDarsadIdDelete] 
    @fldBudje_khedmatDarsadId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [BUD].[tblBudje_khedmatDarsadId]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldBudje_khedmatDarsadId] = @fldBudje_khedmatDarsadId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [BUD].[tblBudje_khedmatDarsadId]
	WHERE  [fldBudje_khedmatDarsadId] = @fldBudje_khedmatDarsadId
	if (@@error<>0)
		rollback
	COMMIT
GO
