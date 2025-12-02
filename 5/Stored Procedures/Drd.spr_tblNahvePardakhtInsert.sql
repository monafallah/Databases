SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNahvePardakhtInsert] 
    
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldCodePardakht nvarchar(3)
    
AS 
	
	BEGIN TRAN
	set  @fldTitle=com.fn_TextNormalize(@fldTitle)
	set  @fldCodePardakht=com.fn_TextNormalize(@fldCodePardakht)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblNahvePardakht] 
	INSERT INTO [Drd].[tblNahvePardakht] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate],fldCodePardakht)
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, getdate(),@fldCodePardakht
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
