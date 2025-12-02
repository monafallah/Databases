SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterSenderInsert] 
    
    @fldLetterID bigint = NULL,
    @fldMessageId int = NULL,
    --@fldAshkhasHoghoghiId int,
	@fldShakhsHoghoghiTitlesId int,
    @fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblExternalLetterSender] 

	INSERT INTO [Auto].[tblExternalLetterSender] ([fldID], [fldLetterID], [fldMessageId], /*[fldAshkhasHoghoghiId],*/fldShakhsHoghoghiTitlesId, [fldDate], [fldOrganId], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldLetterID, @fldMessageId,/* @fldAshkhasHoghoghiId,*/@fldShakhsHoghoghiTitlesId, getdate(), @fldOrganId, @fldUserID, @fldDesc, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
