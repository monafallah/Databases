SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterSenderDelete] 
@fldID bigint,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Auto].[tblExternalLetterSender]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldLetterID=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Auto].[tblExternalLetterSender]
	  where  fldLetterID =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
