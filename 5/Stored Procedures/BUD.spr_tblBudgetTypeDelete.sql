SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudgetTypeDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	 
	  DELETE
	  FROM   [BUD].[tblBudgetType]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	
	COMMIT
GO
