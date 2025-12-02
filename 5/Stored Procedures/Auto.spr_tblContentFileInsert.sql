SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblContentFileInsert] 
   
    @fldName nvarchar(300),
    @fldLetterText varbinary(MAX),
    @fldLetterId bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
     @fldType nvarchar(20),
    @fldIP nvarchar(16)
  
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblContentFile] 

	INSERT INTO [Auto].[tblContentFile] ([fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType])
	SELECT @fldId, @fldName, @fldLetterText, @fldLetterId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP, @fldType
	if(@@Error<>0)
        rollback  
	else
	begin
		if (@fldName is null)
		begin
			update auto.tblLetter
			set fldContentFileID=@fldID
			where fldid=@fldLetterId
			if(@@Error<>0)
			 rollback
		end
	
	end     
	COMMIT
GO
