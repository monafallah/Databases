SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeEydiInsert] 

    @fldYear smallint,
    @fldMaxEydiKarmand int,
    @fldMaxEydiKargar int,
    @fldZaribEydiKargari decimal(8, 3),
    @fldTypeMohasebatMaliyat bit,
    @fldMablaghMoafiatKarmand int,
    @fldMablaghMoafiatKargar int,
    @fldDarsadMaliyatKarmand decimal(5, 3),
    @fldDarsadMaliyatKargar decimal(5, 3),
    @fldTypeMohasebe bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMoteghayerhayeEydi] 
	INSERT INTO [Pay].[tblMoteghayerhayeEydi] ([fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldYear, @fldMaxEydiKarmand, @fldMaxEydiKargar, @fldZaribEydiKargari, @fldTypeMohasebatMaliyat, @fldMablaghMoafiatKarmand, @fldMablaghMoafiatKargar, @fldDarsadMaliyatKarmand, @fldDarsadMaliyatKargar, @fldTypeMohasebe, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
