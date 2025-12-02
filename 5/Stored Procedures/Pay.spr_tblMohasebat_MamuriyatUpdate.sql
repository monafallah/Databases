SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_MamuriyatUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldTedadBaBeytute tinyint,
    @fldTedadBedunBeytute tinyint,
    @fldMablagh int,
    @fldBimePersonal int,
    @fldBimeKarFarma int,
    @fldBimeBikari int,
    @fldBimeSakht int,
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadBimeKarFarma decimal(8, 4),
    @fldDarsadBimeBiKari decimal(8, 4),
    @fldDarsadBimeSakht decimal(8, 4),
    @fldMashmolBime int,
    @fldMashmolMaliyat int,
    @fldKhalesPardakhti int,
    @fldMaliyat int,
    @fldTashilat int,
    @fldNobatePardakht tinyint,
    @fldCostCenterId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat_Mamuriyat]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldTedadBaBeytute] = @fldTedadBaBeytute, [fldTedadBedunBeytute] = @fldTedadBedunBeytute, [fldMablagh] = @fldMablagh, [fldBimePersonal] = @fldBimePersonal, [fldBimeKarFarma] = @fldBimeKarFarma, [fldBimeBikari] = @fldBimeBikari, [fldBimeSakht] = @fldBimeSakht, [fldDarsadBimePersonal] = @fldDarsadBimePersonal, [fldDarsadBimeKarFarma] = @fldDarsadBimeKarFarma, [fldDarsadBimeBiKari] = @fldDarsadBimeBiKari, [fldDarsadBimeSakht] = @fldDarsadBimeSakht, [fldMashmolBime] = @fldMashmolBime, [fldMashmolMaliyat] = @fldMashmolMaliyat, [fldKhalesPardakhti] = @fldKhalesPardakhti, [fldMaliyat] = @fldMaliyat, [fldTashilat] = @fldTashilat, [fldNobatePardakht] = @fldNobatePardakht, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE Pay.tblMohasebat_PersonalInfo
	SET fldCostCenterId=@fldCostCenterId,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldMamuriyatId=@fldId
	IF(@@ERROR<>0)
	ROLLBACK
	end
	
	
	COMMIT TRAN
GO
