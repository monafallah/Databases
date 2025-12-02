SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblP_MaliyatManfiUpdate] 
    @fldId int,
    @fldMohasebeId int,
    @fldMablagh int,
    @fldSal smallint,
    @fldMah tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	UPDATE [Pay].[tblP_MaliyatManfi]
	SET    [fldId] = @fldId, [fldMohasebeId] = @fldMohasebeId, [fldMablagh] = @fldMablagh, [fldSal] = @fldSal, [fldMah] = @fldMah, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
