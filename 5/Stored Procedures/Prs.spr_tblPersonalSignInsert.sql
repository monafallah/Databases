SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalSignInsert] 
  
    @fldCommitionId int,
	@fldFile varbinary(max),
	@fldPasvand varchar(5),
  
    @fldUserId int,
  
    @fldDesc nvarchar(100),
   
    @fldIP varchar(15)
AS 

	
	BEGIN TRAN
	
	declare @fldID int ,  @fldFileId int
	select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldFileId, @fldFile,@fldPasvand, @fldUserId, N'عکس امضاء', GETDATE()
		if (@@ERROR<>0)
		
			ROLLBACK
	else
	begin
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblPersonalSign] 

	INSERT INTO [Prs].[tblPersonalSign] ([fldId],fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldCommitionId,@fldFileId, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback 
	end	      
	COMMIT
GO
