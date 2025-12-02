SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterSignersUpdate] 
    @fldId int,
    @fldLetterMinutId int,
    @fldOrganizationalPostsId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblLetterSigners]
	SET    [fldLetterMinutId] = @fldLetterMinutId, [fldOrganizationalPostsId] = @fldOrganizationalPostsId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
