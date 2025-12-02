SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghi_DetailUpdate] 
    @fldId int,
    @fldMoteghayerhayeHoghoghiId int,
    @fldItemEstekhdamId int,
   
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMoteghayerhayeHoghoghi_Detail]
	SET    [fldId] = @fldId, [fldMoteghayerhayeHoghoghiId] = @fldMoteghayerhayeHoghoghiId, [fldItemEstekhdamId] = @fldItemEstekhdamId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
