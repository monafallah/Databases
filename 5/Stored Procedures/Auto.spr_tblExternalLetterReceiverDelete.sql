SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterReceiverDelete] 
@fldID bigint,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Auto].[tblExternalLetterReceiver]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldLetterID=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Auto].[tblExternalLetterReceiver]
	  where  fldLetterID =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
