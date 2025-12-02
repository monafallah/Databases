SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblRoneveshtDelete] 
@fieldName varchar(50),
@fldID bigint,
@fldUserID int
AS 
	
	BEGIN TRAN
	if (@fieldName='fldLetterId')
	begin
		UPDATE [Auto].[tblRonevesht]
		SET    fldUserId=@fldUserId,flddate=getdate()
		WHERE  fldLetterID=@fldId
		if(@@Error<>0)
			rollback 
		else
		begin  
		  DELETE
		  FROM   [Auto].[tblRonevesht]
		  where  fldLetterID =@fldId
		  if(@@Error<>0)
			  rollback  
		end 
	end
	if (@fieldName='fldId')
	begin
		UPDATE [Auto].[tblRonevesht]
		SET    fldUserId=@fldUserId,flddate=getdate()
		WHERE  fldId=@fldId
		if(@@Error<>0)
			rollback 
		else
		begin  
		  DELETE
		  FROM   [Auto].[tblRonevesht]
		  where  fldId =@fldId
		  if(@@Error<>0)
			  rollback  
		end 
	end
	COMMIT
GO
