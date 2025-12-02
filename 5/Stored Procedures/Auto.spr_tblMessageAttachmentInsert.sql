SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageAttachmentInsert] 
  @fldTitle nvarchar(200),
    @fldMessageId int,
	 @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
   
    @fldUserId int,
    @fldDesc nvarchar(MAX),
   
    @fldOrganId int,
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	declare @fldID int , @fldFileId int
	select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldFileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
		rollback
else
begin
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblMessageAttachment] 

	INSERT INTO [Auto].[tblMessageAttachment] ([fldId],fldTitle, [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP])
	SELECT @fldId,@fldTitle ,@fldMessageId, @fldFileId, @fldUserId, @fldDesc, getdate(), @fldOrganId, @fldIP
	if(@@Error<>0)
        rollback 
end		      
	COMMIT
GO
