SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFormatShomareNameInsert] 
  
    @fldYear smallint,
    @fldFormatShomareName nvarchar(200),
    @fldShomareShoro int,
    @fldUserId int,
	@fldType bit,
    @fldDesc nvarchar(MAX)
  
AS 
	
	BEGIN TRAN
	set @fldFormatShomareName=com.fn_TextNormalize(@fldFormatShomareName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblFormatShomareName] 
	INSERT INTO [Drd].[tblFormatShomareName] ([fldId], [fldYear], [fldFormatShomareName], [fldShomareShoro], [fldUserId], [fldDesc], [fldDate],fldType)
	SELECT @fldId, @fldYear, @fldFormatShomareName, @fldShomareShoro, @fldUserId, @fldDesc, getdate(),@fldType
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
