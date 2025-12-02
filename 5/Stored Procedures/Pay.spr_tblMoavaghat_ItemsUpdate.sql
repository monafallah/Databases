SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghat_ItemsUpdate] 
    @fldId int,
    @fldMoavaghatId int,
    @fldItemEstekhdamId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMoavaghat_Items]
	SET    [fldId] = @fldId, [fldMoavaghatId] = @fldMoavaghatId, [fldItemEstekhdamId] = @fldItemEstekhdamId, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
