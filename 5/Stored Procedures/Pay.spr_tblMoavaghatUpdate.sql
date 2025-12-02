SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghatUpdate] 
    @fldId int,
    @fldMohasebatId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldHaghDarmanKarfFarma int,
    @fldHaghDarmanDolat int,
    @fldHaghDarman int,
    @fldBimePersonal int,
    @fldBimeKarFarma int,
    @fldBimeBikari int,
    @fldBimeMashaghel int,

    @fldPasAndaz int,
    @fldMashmolBime int,
    @fldMashmolMaliyat int,

    @fldMaliyat int,
    @fldHokmId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMoavaghat]
	SET    [fldId] = @fldId, [fldMohasebatId] = @fldMohasebatId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldHaghDarmanKarfFarma] = @fldHaghDarmanKarfFarma, [fldHaghDarmanDolat] = @fldHaghDarmanDolat, [fldHaghDarman] = @fldHaghDarman, [fldBimePersonal] = @fldBimePersonal, [fldBimeKarFarma] = @fldBimeKarFarma, [fldBimeBikari] = @fldBimeBikari, [fldBimeMashaghel] = @fldBimeMashaghel,  [fldPasAndaz] = @fldPasAndaz, [fldMashmolBime] = @fldMashmolBime, [fldMashmolMaliyat] = @fldMashmolMaliyat,  [fldMaliyat] = @fldMaliyat,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldHokmId=@fldHokmId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
