SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblContentFileUpdate] 
    @fldId int,
    @fldName nvarchar(300),
    @fldLetterText varbinary(MAX),
    @fldLetterId bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  @fldType nvarchar(20),
    @fldIP nvarchar(16)
    
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblContentFile]
	SET    [fldName] = @fldName, [fldLetterText] = @fldLetterText, [fldLetterId] = @fldLetterId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP, [fldType] = @fldType
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
