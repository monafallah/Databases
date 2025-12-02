SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblParticularPropertiesUpdate] 
    @fldId int,
    @fldArchiveTreeId int,
    @fldPropertiesId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Arch].[tblParticularProperties]
	SET    [fldArchiveTreeId] = @fldArchiveTreeId, [fldPropertiesId] = @fldPropertiesId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
