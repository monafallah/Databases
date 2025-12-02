SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeField_LetterTemplateDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Auto].[tblMergeField_LetterTemplate]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Auto].[tblMergeField_LetterTemplate]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
