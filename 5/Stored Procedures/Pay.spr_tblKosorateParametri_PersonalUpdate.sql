SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosorateParametri_PersonalUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldParametrId int,
    @fldNoePardakht bit,
    @fldMablagh int,
    @fldTedad int,
    @fldTarikhePardakht nvarchar(10),
    @fldSumFish bit,
    @fldMondeFish bit,
    @fldSumPardakhtiGHabl int,
    @fldMondeGHabl int,
    @fldStatus bit,
    @fldDateDeactive int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKosorateParametri_Personal]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldParametrId] = @fldParametrId, [fldNoePardakht] = @fldNoePardakht, [fldMablagh] = @fldMablagh, [fldTedad] = @fldTedad, [fldTarikhePardakht] = @fldTarikhePardakht, [fldSumFish] = @fldSumFish, [fldMondeFish] = @fldMondeFish, [fldSumPardakhtiGHabl] = @fldSumPardakhtiGHabl, [fldMondeGHabl] = @fldMondeGHabl, [fldStatus] = @fldStatus, [fldDateDeactive] = @fldDateDeactive, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
