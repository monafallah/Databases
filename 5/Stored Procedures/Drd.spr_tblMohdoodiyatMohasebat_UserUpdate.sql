SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMohdoodiyatMohasebat_UserUpdate] 
    @fldId int,
    @fldIdUser int,
    @fldMahdoodiyatMohasebatId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	UPDATE [Drd].[tblMohdoodiyatMohasebat_User]
	SET    [fldId] = @fldId, [fldIdUser] = @fldIdUser, [fldMahdoodiyatMohasebatId] = @fldMahdoodiyatMohasebatId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
