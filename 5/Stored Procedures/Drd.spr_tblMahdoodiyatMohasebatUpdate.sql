SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebatUpdate] 
    @fldId int,
	@fldTitle nvarchar(200),
    @fldAzTarikh nvarchar(10),
    @fldTatarikh nvarchar(10),
    @fldNoeKarbar bit,
    @fldNoeCodeDaramad bit,
    @fldNoeAshkhas bit,
    @fldStatus bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	UPDATE [Drd].[tblMahdoodiyatMohasebat]
	SET    [fldId] = @fldId,[fldTitle]=@fldTitle, [fldAzTarikh] = @fldAzTarikh, [fldTatarikh] = @fldTatarikh, [fldNoeKarbar] = @fldNoeKarbar, [fldNoeCodeDaramad] = @fldNoeCodeDaramad, [fldNoeAshkhas] = @fldNoeAshkhas, [fldStatus] = @fldStatus, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
