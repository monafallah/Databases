SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscalTitleUpdate] 
    @fldId int,
    @fldFiscalHeaderId int,
    @fldItemEstekhdamId int,
   
    @fldAnvaEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblFiscalTitle]
	SET    [fldId] = @fldId, [fldFiscalHeaderId] = @fldFiscalHeaderId, [fldItemEstekhdamId] = @fldItemEstekhdamId, [fldAnvaEstekhdamId] = @fldAnvaEstekhdamId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
