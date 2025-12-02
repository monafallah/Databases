SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblNahvePardakhtUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldCodePardakht nvarchar(3)
  
AS 
	BEGIN TRAN
	set  @fldTitle=com.fn_TextNormalize(@fldTitle)
	set  @fldCodePardakht=com.fn_TextNormalize(@fldCodePardakht)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblNahvePardakht]
	SET    [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate() ,fldCodePardakht=@fldCodePardakht
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
