SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketInsert] 
   @FileId INT OUT,
    @fldHTML nvarchar(MAX),
	@fldSeen BIT,
	@fldFile VARBINARY(MAX),
	@Pasvand NVARCHAR(5),
    @fldUserId int = NULL,
    @fldDesc nvarchar(500),
	@fldTicketCategoryId INT,
	@fldAshkhasId int,
	@fldFileName nvarchar(150),
	@fldInputId INT ,
	@fldSourceForwardId int,
	@fldUserForwarded int,
	@fldSourceReplyId int
AS 
	
	BEGIN TRAN
	SET @fldDesc =dbo.fn_TextNormalize(@fldDesc) 
	SET @fldFileName=dbo.fn_TextNormalize(@fldFileName)
	declare @fldID int ,@flag BIT=0
	IF(@fldFile IS NOT NULL)
	BEGIN
	select @FileId =ISNULL(max(fldId),0)+1 FROM dbo.tblFile
				INSERT INTO dbo.tblFile ( fldId , fldPasvand ,fldFile ,fldDesc,fldSize,fldFileName  )
				SELECT @FileId,@Pasvand,@fldFile,N'تیکت',cast(round((DATALENGTH(@fldFile)/1024.0)/1024.0,2) as decimal(8,2)) ,@fldFileName
				IF (@@Error<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END

	
			IF(@flag=0)
			BEGIN
				
				select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTicket] 
				INSERT INTO [dbo].[tblTicket] ([fldId], [fldHTML],fldSeen,fldFileId,fldTicketCategoryId, [fldUserId],fldAshkhasId , [fldDesc], [fldDate],[fldInputID],fldSourceForwardId,fldUserForwarded,fldSourceReplyId)
				SELECT @fldId,  @fldHTML,@fldSeen,@FileId,@fldTicketCategoryId, @fldUserId,@fldAshkhasId, @fldDesc, GETDATE(),@fldInputID,@fldSourceForwardId,@fldUserForwarded,@fldSourceReplyId
				if(@@ERROR<>0)
				begin
					rollback
				end 
			END
    END
	ELSE
	BEGIN
		SET @FileId=0
		select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTicket] 
				INSERT INTO [dbo].[tblTicket] ([fldId],  [fldHTML],fldSeen,fldFileId,fldTicketCategoryId, [fldUserId],fldAshkhasId , [fldDesc], [fldDate],[fldInputID],fldSourceForwardId,fldUserForwarded,fldSourceReplyId)
				SELECT @fldId, @fldHTML,@fldSeen,NULL,@fldTicketCategoryId, @fldUserId,@fldAshkhasId , @fldDesc, GETDATE(),@fldInputID,@fldSourceForwardId,@fldUserForwarded,@fldSourceReplyId

		if (@@ERROR<>0)
		ROLLBACK
	END
    
	

	COMMIT

GO
