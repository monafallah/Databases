SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblComputationFormulaDelete] 
	@fldID int,
	@fldInputID int
AS 
	BEGIN TRAN
	insert into tbllogtable
	select 2,@fldID,@fldInputID,GETDATE(),3
	if(@@ERROR<>0)
	begin
		rollback
	end
	else
	begin
	DELETE
	FROM   [dbo].[tblComputationFormula]
	WHERE  fldId = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end
end
	COMMIT
GO
