SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPspModelUpdate] 
    @fldId int,
    @fldPspId int,
    @fldModel nvarchar(100),
	@fldMultiHesab BIT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	SET @fldModel=Com.fn_TextNormalize(@fldModel)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPspModel]
	SET    [fldPspId] = @fldPspId, [fldModel] = @fldModel,fldMultiHesab=@fldMultiHesab, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
