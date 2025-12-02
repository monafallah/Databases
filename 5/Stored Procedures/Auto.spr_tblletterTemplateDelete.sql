SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblletterTemplateDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Auto].[tblMergeField_LetterTemplate]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldLetterTamplateId=@fldId
	if(@@Error<>0)
        rollback 
	
	  
	  DELETE
	  FROM   [Auto].[tblMergeField_LetterTemplate]
	  where  fldLetterTamplateId =@fldId
	  if(@@Error<>0)
          rollback  
	 
	else 
	begin
		UPDATE [Auto].[tblletterTemplate]
		SET    fldUserId=@fldUserId,flddate=getdate()
		WHERE  fldId=@fldId
		if(@@Error<>0)
			rollback 
		else
		begin  
		  DELETE
		  FROM   [Auto].[tblletterTemplate]
		  where  fldId =@fldId
		  if(@@Error<>0)
			  rollback  
		end 
	end
	COMMIT
GO
