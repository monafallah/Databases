SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterSignersInsert] 
   
    @fldLetterMinutId int,
    @fldOrganizationalPostsId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblLetterSigners] 
	INSERT INTO [Drd].[tblLetterSigners] ([fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldLetterMinutId, @fldOrganizationalPostsId, @fldUserId, @fldDesc,getDate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
