SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParameteriItemsFormulUpdate] 
    @fldId int,
    @fldParametrId int,
    @fldFormul nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldFormul=Com.fn_TextNormalize(@fldFormul)
	UPDATE [Pay].[tblParameteriItemsFormul]
	SET    [fldId] = @fldId, [fldParametrId] = @fldParametrId, [fldFormul] = @fldFormul, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
