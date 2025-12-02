SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblHistoryLetterInsert] 
 
    @fldCurrentLetter_Id bigint,
    @fldHistoryType_Id int,
    @fldHistoryLetter_Id bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100) = NULL,
    
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblHistoryLetter] 

	INSERT INTO [Auto].[tblHistoryLetter] ([fldId], [fldCurrentLetter_Id], [fldHistoryType_Id], [fldHistoryLetter_Id], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldCurrentLetter_Id, @fldHistoryType_Id, @fldHistoryLetter_Id, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
