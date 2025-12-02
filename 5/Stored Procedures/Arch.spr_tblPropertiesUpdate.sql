SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesUpdate] 
    @fldId int,
    @fldNameFn nvarchar(100),
	@fldNameEn nvarchar(100),
    @fldType int,
    @fldFormulId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldNameFn=Com.fn_TextNormalize(@fldNameFn)
	SET @fldNameEn=Com.fn_TextNormalize(@fldNameEn)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Arch].[tblProperties]
	SET    fldNameFn = @fldNameFn,fldNameEn=@fldNameEn, [fldType] = @fldType, [fldFormulId] = @fldFormulId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =  GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
