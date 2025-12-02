SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatManfiUpdate] 
    @fldId int,
    @fldMablagh int,
    @fldMohasebeId int,
    @fldSal SMALLINT,
    @fldMah tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMaliyatManfi]
	SET    [fldId] = @fldId, [fldMablagh] = @fldMablagh, [fldMohasebeId] = @fldMohasebeId, [fldSal] = @fldSal, [fldMah] = @fldMah, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
