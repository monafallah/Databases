SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartablDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Dead].[tblKartabl]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Dead].[tblKartabl]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
