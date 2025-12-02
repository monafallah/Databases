SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatEzafeKari_TatilKariUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldTedad DECIMAL(6,3),
    @fldMablagh int,
    @fldBimePersonal int,
    @fldBimeKarFarma int,
    @fldBimeBikari int,
    @fldBimeSakht int,
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadBimeKarFarma decimal(8, 4),
    @fldDarsadBimeBikari decimal(8, 4),
    @fldDarsadBimeSakht decimal(8, 4),
    @fldMashmolBime int,
    @fldMashmolMaliyat int,
    @fldNobatPardakht int,
    @fldType tinyint,
    @fldKhalesPardakhti int,
    @fldMaliyat int,
    @fldCostCenterId INT ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebatEzafeKari_TatilKari]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldTedad] = @fldTedad, [fldMablagh] = @fldMablagh, [fldBimePersonal] = @fldBimePersonal, [fldBimeKarFarma] = @fldBimeKarFarma, [fldBimeBikari] = @fldBimeBikari, [fldBimeSakht] = @fldBimeSakht, [fldDarsadBimePersonal] = @fldDarsadBimePersonal, [fldDarsadBimeKarFarma] = @fldDarsadBimeKarFarma, [fldDarsadBimeBikari] = @fldDarsadBimeBikari, [fldDarsadBimeSakht] = @fldDarsadBimeSakht, [fldMashmolBime] = @fldMashmolBime, [fldMashmolMaliyat] = @fldMashmolMaliyat, [fldNobatPardakht] = @fldNobatPardakht, [fldType] = @fldType, [fldKhalesPardakhti] = @fldKhalesPardakhti, [fldMaliyat] = @fldMaliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	 UPDATE Pay.tblMohasebat_PersonalInfo
	 SET fldCostCenterId=@fldCostCenterId ,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	 WHERE fldEzafe_TatilKariId=@fldId
	 	COMMIT TRAN
GO
