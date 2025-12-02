SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFormatShomareNameUpdate] 
    @fldId int,
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
	UPDATE [Drd].[tblFormatShomareName]
	SET    [fldYear] = @fldYear, [fldFormatShomareName] = @fldFormatShomareName, [fldShomareShoro] = @fldShomareShoro, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldType=@fldType
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
