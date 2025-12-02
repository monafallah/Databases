SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_KosoratBankUpdate] 
    @fldId int,
    @fldMohasebatId int,
    @fldKosoratBankId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat_KosoratBank]
	SET    [fldId] = @fldId, [fldMohasebatId] = @fldMohasebatId, [fldKosoratBankId] = @fldKosoratBankId, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
