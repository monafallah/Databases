SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRequestAmanatDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Dead].[tblRequestAmanat]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Dead].[tblRequestAmanat]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
