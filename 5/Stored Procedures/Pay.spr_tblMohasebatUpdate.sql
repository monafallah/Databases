SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldKarkard tinyint,
    @fldGheybat tinyint,
    @fldTedadEzafeKar DECIMAL(6,3),
    @fldTedadTatilKar DECIMAL(6,3),
    @fldBaBeytute tinyint,
    @fldBedunBeytute tinyint,
    @fldBimeOmrKarFarma int,
    @fldBimeOmr int,
    @fldBimeTakmilyKarFarma int,
    @fldBimeTakmily int,
    @fldHaghDarmanKarfFarma int,
    @fldHaghDarmanDolat int,
    @fldHaghDarman int,
    @fldBimePersonal int,
    @fldBimeKarFarma int,
    @fldBimeBikari int,
    @fldBimeMashaghel int,
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadBimeKarFarma decimal(8, 4),
    @fldDarsadBimeBikari decimal(8, 4),
    @fldDarsadBimeSakht decimal(8, 4),
    @fldTedadNobatKari tinyint,
    @fldMosaede int,
    @fldNobatPardakht int,
    @fldGhestVam int,
    @fldPasAndaz int,
    @fldMashmolBime int,
    @fldMashmolMaliyat int,
    @fldFlag bit,

    @fldMogharari int,
    @fldMaliyat int,
  
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldShift INT
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldKarkard] = @fldKarkard, [fldGheybat] = @fldGheybat, [fldTedadEzafeKar] = @fldTedadEzafeKar, [fldTedadTatilKar] = @fldTedadTatilKar, [fldBaBeytute] = @fldBaBeytute, [fldBedunBeytute] = @fldBedunBeytute, [fldBimeOmrKarFarma] = @fldBimeOmrKarFarma, [fldBimeOmr] = @fldBimeOmr, [fldBimeTakmilyKarFarma] = @fldBimeTakmilyKarFarma, [fldBimeTakmily] = @fldBimeTakmily, [fldHaghDarmanKarfFarma] = @fldHaghDarmanKarfFarma, [fldHaghDarmanDolat] = @fldHaghDarmanDolat, [fldHaghDarman] = @fldHaghDarman, [fldBimePersonal] = @fldBimePersonal, [fldBimeKarFarma] = @fldBimeKarFarma, [fldBimeBikari] = @fldBimeBikari, [fldBimeMashaghel] = @fldBimeMashaghel, [fldDarsadBimePersonal] = @fldDarsadBimePersonal, [fldDarsadBimeKarFarma] = @fldDarsadBimeKarFarma, [fldDarsadBimeBikari] = @fldDarsadBimeBikari, [fldDarsadBimeSakht] = @fldDarsadBimeSakht, [fldTedadNobatKari] = @fldTedadNobatKari, [fldMosaede] = @fldMosaede, [fldNobatPardakht] = @fldNobatPardakht, [fldGhestVam] = @fldGhestVam, [fldPasAndaz] = @fldPasAndaz, [fldMashmolBime] = @fldMashmolBime, [fldMashmolMaliyat] = @fldMashmolMaliyat, [fldFlag] = @fldFlag,  [fldMogharari] = @fldMogharari, [fldMaliyat] = @fldMaliyat,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldShift=@fldShift
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
