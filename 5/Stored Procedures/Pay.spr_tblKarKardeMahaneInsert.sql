SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardeMahaneInsert] 
@fldID int  out,
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
    @fldShift int,
	@fldMoavaghe bit	,
	@fldAzTarikhMoavaghe int	,
	@fldTaTarikhMoavaghe int	,
	@fldMeetingCount smallint,
    @fldEstelagi tinyint
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)

	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKarKardeMahane] 
	INSERT INTO [Pay].[tblKarKardeMahane] ([fldId], [fldPersonalId], [fldYear], [fldMah], [fldKarkard], [fldGheybat], [fldNobateKari], [fldEzafeKari], [fldTatileKari], [fldMamoriatBaBeitote], [fldMamoriatBedoneBeitote], [fldMosaedeh], [fldNobatePardakht], [fldFlag], [fldGhati], [fldBa10], [fldBa20], [fldBa30], [fldBe10], [fldBe20], [fldBe30], [fldUserId], [fldDate], [fldDesc],fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,fldMeetingCount,fldEstelagi)
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMah, @fldKarkard, @fldGheybat, @fldNobateKari, @fldEzafeKari, @fldTatileKari, @fldMamoriatBaBeitote, @fldMamoriatBedoneBeitote, @fldMosaedeh, @fldNobatePardakht, @fldFlag, @fldGhati, @fldBa10, @fldBa20, @fldBa30, @fldBe10, @fldBe20, @fldBe30, @fldUserId, GETDATE(), @fldDesc,@fldShift,@fldMoavaghe,@fldAzTarikhMoavaghe,@fldTaTarikhMoavaghe,@fldMeetingCount,@fldEstelagi
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
