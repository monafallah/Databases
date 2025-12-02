SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_ItemsUpdate] 
    @fldId int,
    @fldMohasebatId int,
    @fldItemEstekhdamId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat_Items]
	SET    [fldId] = @fldId, [fldMohasebatId] = @fldMohasebatId, [fldItemEstekhdamId] = @fldItemEstekhdamId, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
