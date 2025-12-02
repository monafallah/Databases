SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEzafeKari_TatilKariUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatePardakht tinyint,
    @fldCount DECIMAL(6,3),
    @fldType tinyint,
    @fldHasBime	bit	,
	@fldHasMaliyat	bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblEzafeKari_TatilKari]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldNobatePardakht] = @fldNobatePardakht, [fldCount] = @fldCount, [fldType] = @fldType, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldHasBime=@fldHasBime,fldHasMaliyat=@fldHasMaliyat
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	ROLLBACK
	
	COMMIT TRAN
GO
