SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFormatFileUpdate] 
    @fldId int,
    @fldFormatName nvarchar(50),
    @fldPassvand varchar(100),
    @fldIcon varbinary(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldFormatName=Com.fn_TextNormalize(@fldFormatName)
	SET @fldPassvand=Com.fn_TextNormalize(@fldPassvand)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Arch].[tblFormatFile]
	SET    [fldFormatName] = @fldFormatName, [fldPassvand] = @fldPassvand, [fldIcon] = @fldIcon, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
