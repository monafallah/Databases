SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_MorakhasiUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldTedad tinyint,
    @fldMablagh int,
    @fldMonth tinyint,
    @fldYear smallint,
    @fldNobatPardakht tinyint,
    @fldSalHokm smallint,
    @fldHokmId int,
    @fldCostCenterId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMohasebat_Morakhasi]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldTedad] = @fldTedad, [fldMablagh] = @fldMablagh, [fldMonth] = @fldMonth, [fldYear] = @fldYear, [fldNobatPardakht] = @fldNobatPardakht, [fldSalHokm] = @fldSalHokm, [fldHokmId] = @fldHokmId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
