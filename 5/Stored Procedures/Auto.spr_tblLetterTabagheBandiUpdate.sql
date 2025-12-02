SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterTabagheBandiUpdate] 
    @fldId int,
    @fldTabagheBandiId int,
	  @fldMessageId int = NULL,
    @fldLetterId bigint = NULL,
  
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblLetterTabagheBandi]
	SET    [fldTabagheBandiId] = @fldTabagheBandiId, [fldLetterId] = @fldLetterId, [fldMessageId] = @fldMessageId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
