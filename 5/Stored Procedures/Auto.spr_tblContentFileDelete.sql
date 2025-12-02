SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblContentFileDelete] 
@fldID bigint,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Auto].[tblContentFile]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldLetterId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Auto].[tblContentFile]
	  where  fldLetterId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
