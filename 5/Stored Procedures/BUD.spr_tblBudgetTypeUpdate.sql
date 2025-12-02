SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudgetTypeUpdate] 
    @fldId int,
    @fldTitle nvarchar(100)
	
AS 

	BEGIN TRAN

	UPDATE [BUD].[tblBudgetType]
	SET    [fldTitle] = @fldTitle
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
