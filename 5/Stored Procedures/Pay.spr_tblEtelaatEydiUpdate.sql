SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEtelaatEydiUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldDayCount int,
    @fldKosurat int,
    @fldNobatePardakht tinyint,
    @fldUserId int,

    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblEtelaatEydi]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldDayCount] = @fldDayCount, [fldKosurat] = @fldKosurat, [fldNobatePardakht] = @fldNobatePardakht, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
