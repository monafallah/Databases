SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_ShomareHesabDaramadUpdate] 
    @fldId int,
    @fldMahdodiyatMohasebatId int,
    @fldShomarehesabDarmadId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	UPDATE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]
	SET    [fldId] = @fldId, [fldMahdodiyatMohasebatId] = @fldMahdodiyatMohasebatId, [fldShomarehesabDarmadId] = @fldShomarehesabDarmadId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
