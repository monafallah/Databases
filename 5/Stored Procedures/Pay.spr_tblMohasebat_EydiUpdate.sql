SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_EydiUpdate] 
	@fldId INT,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldDayCount int,
    @fldMablagh int,
    @fldMaliyat int,
    @fldKosurat int,
    @fldKhalesPardakhti int,
    @fldNobatPardakht int,
    @fldCostCenterId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	DECLARE @flag BIT=0
	UPDATE [Pay].[tblMohasebat_Eydi]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldDayCount] = @fldDayCount, [fldMablagh] = @fldMablagh, [fldMaliyat] = @fldMaliyat, [fldKosurat] = @fldKosurat, [fldKhalesPardakhti] = @fldKhalesPardakhti, [fldNobatPardakht] = @fldNobatPardakht, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
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
	WHERE fldMohasebatEydiId=@fldId
	IF(@@ERROR<>0)
	ROLLBACK
	end
	
	COMMIT TRAN
GO
