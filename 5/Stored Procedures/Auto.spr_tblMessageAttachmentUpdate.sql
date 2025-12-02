SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageAttachmentUpdate] 
    @fldId int,
	  @fldTitle nvarchar(200),
    @fldMessageId int,
    @fldFileId int,
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
	update [Com].[tblFile]
		set fldImage=@fldImage,fldPasvand=@fldPasvand,fldUserId=@fldUserId,fldDate=GETDATE()
		where fldid=@fldFileId
		if (@@error<>0)
		rollback
else
	begin
	UPDATE [Auto].[tblMessageAttachment]
	SET    [fldMessageId] = @fldMessageId,fldTitle=@fldTitle, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   
end
	COMMIT
GO
