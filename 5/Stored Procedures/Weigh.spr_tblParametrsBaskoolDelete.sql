SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrsBaskoolDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Weigh].[tblParametrsBaskool]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Weigh].[tblParametrsBaskool]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
