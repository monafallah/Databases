SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghatInsert] 
	@fldId INT out ,
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
	@fldMashmolBimeNaKhales int,
    @fldMashmolMaliyat int,
    @fldMaliyat int,
	@fldHokmId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	--declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMoavaghat] 
	INSERT INTO [Pay].[tblMoavaghat] ([fldId], [fldMohasebatId], [fldYear], [fldMonth], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat],  [fldMaliyat],fldMaliyatCalc,  [fldUserId], [fldDesc], [fldDate],fldHokmId,fldMashmolBimeNaKhales)
	SELECT @fldId, @fldMohasebatId, @fldYear, @fldMonth, @fldHaghDarmanKarfFarma, @fldHaghDarmanDolat, @fldHaghDarman, @fldBimePersonal, @fldBimeKarFarma, @fldBimeBikari, @fldBimeMashaghel, @fldPasAndaz, @fldMashmolBime, @fldMashmolMaliyat,0, @fldMaliyat, @fldUserId, @fldDesc, GETDATE(),@fldHokmId,@fldMashmolBimeNaKhales
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
