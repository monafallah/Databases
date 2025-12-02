SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterAttachmentInsert] 
    @fldLetterId bigint,
	
    @fldName nvarchar(100),
	@fldNameFile nvarchar(200),
	@file varbinary(Max),
	@fldType nvarchar(max),
    @fldUserId int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID int,  @fldContentFileID int,@flag bit=0
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterAttachment]
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldNameFile=com.fn_TextNormalize(@fldNameFile)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	if ( @fldLetterId is not null)
	begin
		select @fldContentFileID =ISNULL(max(fldId),0)+1 from [Auto].[tblContentFile]
	insert into[Auto].[tblContentFile]
	select @fldContentFileID,@fldNameFile,@file,@fldLetterId,@fldUserID,@fldOrganId,@fldDesc,getdate(),@fldIP,@fldType
	if (@@error<>0)
	begin
	rollback
	set @flag=1
	end
	end

	if (@flag=0)
	begin
	INSERT INTO [Auto].[tblLetterAttachment] ([fldID], [fldLetterID], [fldName], [fldContentFileID], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIP)
	
	SELECT @fldID, @fldLetterID, @fldName, @fldContentFileID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK
end
	COMMIT TRAN
	
GO
