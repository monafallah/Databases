SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudgetTypeInsert] 
   
    @fldTitle nvarchar(100)
	
   
   
  
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [BUD].[tblBudgetType] 

	INSERT INTO [BUD].[tblBudgetType] ([fldId], [fldTitle])
	SELECT @fldId, @fldTitle
	if(@@Error<>0)
        rollback       
	COMMIT
GO
