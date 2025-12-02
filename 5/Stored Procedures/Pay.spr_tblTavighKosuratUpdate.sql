SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTavighKosuratUpdate] 
    @fldId int,
    @fldKosuratId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblTavighKosurat]
	SET    [fldId] = @fldId, [fldKosuratId] = @fldKosuratId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
