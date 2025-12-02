SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterFileMojazInsert] 
   
    @fldFormatFileId int,
	@fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
   
    @fldOrganId int,
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterFileMojaz] 

	INSERT INTO [Auto].[tblLetterFileMojaz] ([fldId], [fldFormatFileId],fldType, [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP])
	SELECT @fldId, @fldFormatFileId,@fldType, @fldUserId, @fldDesc, getdate(), @fldOrganId, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
