SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghiUpdate] 
    @fldId int,
    @fldTarikhEjra nvarchar(10),
    @fldTarikhSodur nvarchar(10),
    @fldAnvaeEstekhdamId int,
    @fldTypeBimeId int,
    @fldZaribEzafeKar int,
    @fldSaatKari decimal(8, 4),
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadbimeKarfarma decimal(8, 4),
    @fldDarsadBimeBikari decimal(8, 4),
    @fldDarsadBimeJanbazan decimal(8, 4),
    @fldHaghDarmanKarmand decimal(8, 4),
    @fldHaghDarmanKarfarma decimal(8, 4),
    @fldHaghDarmanDolat decimal(8, 4),
    @fldHaghDarmanMazad int,
    @fldHaghDarmanTahteTakaffol int,
    @fldDarsadBimeMashagheleZiyanAvar decimal(8, 4),
    @fldMaxHaghDarman int,
    @fldZaribHoghoghiSal int,
    @fldHoghogh bit,
    @fldFoghShoghl bit,
    @fldTafavotTatbigh bit,
    @fldFoghVizhe bit,
    @fldHaghJazb bit,
    @fldTadil bit,
    @fldBarJastegi bit,
    @fldSanavat bit,
	@fldFoghTalash BIT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMoteghayerhayeHoghoghi]
	SET    [fldId] = @fldId, [fldTarikhEjra] = @fldTarikhEjra, [fldTarikhSodur] = @fldTarikhSodur, [fldAnvaeEstekhdamId] = @fldAnvaeEstekhdamId, [fldTypeBimeId] = @fldTypeBimeId, [fldZaribEzafeKar] = @fldZaribEzafeKar, [fldSaatKari] = @fldSaatKari, [fldDarsadBimePersonal] = @fldDarsadBimePersonal, [fldDarsadbimeKarfarma] = @fldDarsadbimeKarfarma, [fldDarsadBimeBikari] = @fldDarsadBimeBikari, [fldDarsadBimeJanbazan] = @fldDarsadBimeJanbazan, [fldHaghDarmanKarmand] = @fldHaghDarmanKarmand, [fldHaghDarmanKarfarma] = @fldHaghDarmanKarfarma, [fldHaghDarmanDolat] = @fldHaghDarmanDolat, [fldHaghDarmanMazad] = @fldHaghDarmanMazad, [fldHaghDarmanTahteTakaffol] = @fldHaghDarmanTahteTakaffol, [fldDarsadBimeMashagheleZiyanAvar] = @fldDarsadBimeMashagheleZiyanAvar, [fldMaxHaghDarman] = @fldMaxHaghDarman, [fldZaribHoghoghiSal] = @fldZaribHoghoghiSal, [fldHoghogh] = @fldHoghogh, [fldFoghShoghl] = @fldFoghShoghl, [fldTafavotTatbigh] = @fldTafavotTatbigh, [fldFoghVizhe] = @fldFoghVizhe, [fldHaghJazb] = @fldHaghJazb, [fldTadil] = @fldTadil, [fldBarJastegi] = @fldBarJastegi, [fldSanavat] = @fldSanavat,fldFoghTalash=@fldFoghTalash, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
