SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblTanzimateDaramadUpdate] 
    @fldId int,
    @fldAvarezId int,
    @fldMaliyatId int,
    @fldTakhirId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldMablaghGerdKardan int,
	@fldOrganId int,
	@fldChapShenaseGhabz_Pardakht bit,
	@fldShorooshenaseGhabz tinyint,
	@fldShomareHesabIdPishfarz int,
	@fldSumMaliyat_Avarez bit 
 
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblTanzimateDaramad]
	SET    [fldAvarezId] = @fldAvarezId, [fldMaliyatId] = @fldMaliyatId, [fldTakhirId] = @fldTakhirId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldMablaghGerdKardan=@fldMablaghGerdKardan,fldOrganId=@fldOrganId,fldChapShenaseGhabz_Pardakht=@fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz=@fldShorooshenaseGhabz ,fldShomareHesabIdPishfarz=@fldShomareHesabIdPishfarz 
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
