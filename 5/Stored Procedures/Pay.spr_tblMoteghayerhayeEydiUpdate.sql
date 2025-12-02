SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeEydiUpdate] 
    @fldId int,
    @fldYear smallint,
    @fldMaxEydiKarmand int,
    @fldMaxEydiKargar int,
    @fldZaribEydiKargari decimal(8,3),
    @fldTypeMohasebatMaliyat bit,
    @fldMablaghMoafiatKarmand int,
    @fldMablaghMoafiatKargar int,
    @fldDarsadMaliyatKarmand decimal(5,2),
    @fldDarsadMaliyatKargar decimal(5,2),
    @fldTypeMohasebe bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMoteghayerhayeEydi]
	SET    [fldId] = @fldId, [fldYear] = @fldYear, [fldMaxEydiKarmand] = @fldMaxEydiKarmand, [fldMaxEydiKargar] = @fldMaxEydiKargar, [fldZaribEydiKargari] = @fldZaribEydiKargari, [fldTypeMohasebatMaliyat] = @fldTypeMohasebatMaliyat, [fldMablaghMoafiatKarmand] = @fldMablaghMoafiatKarmand, [fldMablaghMoafiatKargar] = @fldMablaghMoafiatKargar, [fldDarsadMaliyatKarmand] = @fldDarsadMaliyatKarmand, [fldDarsadMaliyatKargar] = @fldDarsadMaliyatKargar, [fldTypeMohasebe] = @fldTypeMohasebe, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
