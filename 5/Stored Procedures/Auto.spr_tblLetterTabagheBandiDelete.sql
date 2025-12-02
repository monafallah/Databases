SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterTabagheBandiDelete] 
@fieldName nvarchar(50),
@fldID bigint,
@fldUserID int
AS 
	

	BEGIN TRAN
	if (@fieldName='LetterId')
	begin
		UPDATE [Auto].[tblLetterTabagheBandi]
		SET    fldUserId=@fldUserId,flddate=getdate()
		WHERE  fldLetterId=@fldId
		if(@@Error<>0)
			rollback 
		else
		begin  
		  DELETE
		  FROM   [Auto].[tblLetterTabagheBandi]
		  where  fldLetterId =@fldId
		  if(@@Error<>0)
			  rollback  
		end 
	end
	if (@fieldName='MessageId')
	begin
		UPDATE [Auto].[tblLetterTabagheBandi]
		SET    fldUserId=@fldUserId,flddate=getdate()
		WHERE  fldMessageId=@fldId
		if(@@Error<>0)
			rollback 
		else
		begin  
		  DELETE
		  FROM   [Auto].[tblLetterTabagheBandi]
		  where  fldMessageId =@fldId
		  if(@@Error<>0)
			  rollback  
		end 
	end
	COMMIT
GO
