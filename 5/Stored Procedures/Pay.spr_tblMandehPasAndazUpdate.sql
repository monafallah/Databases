SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMandehPasAndazUpdate] 
    @fldId int,
    @fldPersonalId int,
    @FldMablagh int,
    @fldTarikhSabt nvarchar(10),
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMandehPasAndaz]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [FldMablagh] = @FldMablagh, [fldTarikhSabt] = @fldTarikhSabt, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
