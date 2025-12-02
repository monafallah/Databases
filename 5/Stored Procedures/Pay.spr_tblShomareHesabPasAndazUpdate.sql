SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabPasAndazUpdate] 
    @fldId int,
    @fldShomareHesabPersonalId int,
    @fldShomareHesabKarfarmaId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblShomareHesabPasAndaz]
	SET    [fldId] = @fldId, [fldShomareHesabPersonalId] = @fldShomareHesabPersonalId, [fldShomareHesabKarfarmaId] = @fldShomareHesabKarfarmaId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
