SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_kosorat/MotalebatParamUpdate] 
    @fldId int,
    @fldMohasebatId int,
    @fldKosoratId int,
    @fldMotalebatId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat_kosorat/MotalebatParam]
	SET    [fldId] = @fldId, [fldMohasebatId] = @fldMohasebatId, [fldKosoratId] = @fldKosoratId, [fldMotalebatId] = @fldMotalebatId, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
