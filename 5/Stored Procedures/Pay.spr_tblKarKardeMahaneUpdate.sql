SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardeMahaneUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMah tinyint,
    @fldKarkard tinyint,
    @fldGheybat tinyint,
    @fldNobateKari tinyint,
    @fldEzafeKari DECIMAL(6,3),
    @fldTatileKari DECIMAL(6,3),
    @fldMamoriatBaBeitote tinyint,
    @fldMamoriatBedoneBeitote tinyint,
    @fldMosaedeh int,
    @fldNobatePardakht tinyint,
    @fldFlag bit,
    @fldGhati bit,
    @fldBa10 tinyint,
    @fldBa20 tinyint,
    @fldBa30 tinyint,
    @fldBe10 tinyint,
    @fldBe20 tinyint,
    @fldBe30 tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldShift INT,
	@fldMoavaghe bit	,
	@fldAzTarikhMoavaghe int	,
	@fldTaTarikhMoavaghe int,
	@fldMeetingCount smallint,
    @fldEstelagi tinyint
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKarKardeMahane]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMah] = @fldMah, [fldKarkard] = @fldKarkard, [fldGheybat] = @fldGheybat, [fldNobateKari] = @fldNobateKari, [fldEzafeKari] = @fldEzafeKari, [fldTatileKari] = @fldTatileKari, [fldMamoriatBaBeitote] = @fldMamoriatBaBeitote, [fldMamoriatBedoneBeitote] = @fldMamoriatBedoneBeitote, [fldMosaedeh] = @fldMosaedeh, [fldNobatePardakht] = @fldNobatePardakht, [fldFlag] = @fldFlag,  [fldBa10] = @fldBa10, [fldBa20] = @fldBa20, [fldBa30] = @fldBa30, [fldBe10] = @fldBe10, [fldBe20] = @fldBe20, [fldBe30] = @fldBe30, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,
	fldShift=@fldShift,fldMoavaghe=@fldMoavaghe,fldAzTarikhMoavaghe=@fldAzTarikhMoavaghe,fldTaTarikhMoavaghe=@fldTaTarikhMoavaghe,fldMeetingCount=@fldMeetingCount,fldEstelagi=@fldEstelagi
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
