SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParametrsUpdate] 
    @fldId int,
    @fldTitle nvarchar(200),
    @fldTypeParametr bit,
    @fldTypeMablagh bit,
    @fldTypeEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldActive	bit	,
	@fldPrivate	bit	,
	@fldHesabTypeParam	tinyint	,
	@fldIsMostamar	tinyint	,
	@fldOrganId int
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	UPDATE [Pay].[tblParametrs]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldTypeParametr] = @fldTypeParametr, [fldTypeMablagh] = @fldTypeMablagh, [fldTypeEstekhdamId] = @fldTypeEstekhdamId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldActive=@fldActive,fldPrivate=@fldPrivate,fldHesabTypeParam=@fldHesabTypeParam,fldOrganId=@fldOrganId,fldIsMostamar=@fldIsMostamar
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
