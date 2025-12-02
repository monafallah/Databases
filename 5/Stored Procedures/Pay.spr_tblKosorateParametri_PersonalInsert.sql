SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosorateParametri_PersonalInsert] 

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
	DECLARE @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
		select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKosorateParametri_Personal] 
		INSERT INTO [Pay].[tblKosorateParametri_Personal] ([fldId], [fldPersonalId], [fldParametrId], [fldNoePardakht], [fldMablagh], [fldTedad], [fldTarikhePardakht], [fldSumFish], [fldMondeFish], [fldSumPardakhtiGHabl], [fldMondeGHabl], [fldStatus], [fldDateDeactive], [fldUserId], [fldDesc], [fldDate])
		SELECT @fldId, @fldPersonalId, @fldParametrId, @fldNoePardakht, @fldMablagh, @fldTedad, @fldTarikhePardakht, @fldSumFish, @fldMondeFish, @fldSumPardakhtiGHabl, @fldMondeGHabl, @fldStatus, @fldDateDeactive, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
			ROLLBACK
	COMMIT
GO
