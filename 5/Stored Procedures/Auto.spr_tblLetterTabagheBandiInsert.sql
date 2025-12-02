SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterTabagheBandiInsert] 

    @fldTabagheBandiId int,
    @fldLetterId bigint = NULL,
    @fldMessageId int = NULL,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterTabagheBandi] 

	INSERT INTO [Auto].[tblLetterTabagheBandi] ([fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], [fldUserId], [fldOrganId], [fldDesc], [fldIP], [fldDate])
	SELECT @fldId, @fldTabagheBandiId, @fldLetterId, @fldMessageId, @fldUserId, @fldOrganId, @fldDesc, @fldIP, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
