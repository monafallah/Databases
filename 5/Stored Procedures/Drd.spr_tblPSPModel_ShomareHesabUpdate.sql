SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPSPModel_ShomareHesabUpdate] 
    @fldId int,
    @fldPSPModelId int,
    @fldShHesabId int,
    @fldOrder tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblPSPModel_ShomareHesab]
	SET    [fldPSPModelId] = @fldPSPModelId, [fldShHesabId] = @fldShHesabId, [fldOrder] = @fldOrder, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
