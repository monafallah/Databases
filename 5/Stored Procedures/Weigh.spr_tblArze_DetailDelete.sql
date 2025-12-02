SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArze_DetailDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Weigh].[tblArze_Detail]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldHeaderId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Weigh].[tblArze_Detail]
	  where  fldHeaderId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
