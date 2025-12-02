SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPcPosParam_DetailUpdate] 
    @fldId int,
    @fldPcPosParamId int,
    @fldPcPosInfoId int,
    @fldValue nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
 
AS 
	BEGIN TRAN
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPcPosParam_Detail]
	SET    [fldPcPosParamId] = @fldPcPosParamId, [fldPcPosInfoId] = @fldPcPosInfoId, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
