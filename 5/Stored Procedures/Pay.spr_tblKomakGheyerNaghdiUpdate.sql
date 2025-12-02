SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKomakGheyerNaghdiUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNoeMostamer bit,
    @fldMablagh int,
    @fldKhalesPardakhti int,
    @fldMaliyat int,
    @fldShomareHesabId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKomakGheyerNaghdi]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldNoeMostamer] = @fldNoeMostamer, [fldMablagh] = @fldMablagh, [fldKhalesPardakhti] = @fldKhalesPardakhti, [fldMaliyat] = @fldMaliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldShomareHesabId=@fldShomareHesabId
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
			ROLLBACK
			SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE Pay.tblMohasebat_PersonalInfo
	SET /*fldCostCenterId=@fldCostCenterId ,*/fldShomareHesabId=@fldShomareHesabId ,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldKomakGheyerNaghdiId=@fldId
	end
	COMMIT TRAN
GO
