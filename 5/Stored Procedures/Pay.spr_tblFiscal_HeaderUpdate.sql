SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_HeaderUpdate] 
    @fldId int,
    @fldEffectiveDate nvarchar(10),
    @fldDateOfIssue nvarchar(10),
    @fldUserId int,

    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblFiscal_Header]
	SET    [fldId] = @fldId, [fldEffectiveDate] = @fldEffectiveDate, [fldDateOfIssue] = @fldDateOfIssue, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
