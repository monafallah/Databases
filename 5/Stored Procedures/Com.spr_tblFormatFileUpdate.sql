SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblFormatFileUpdate] 
    @fldId tinyint,
    @fldFormatName nvarchar(50),
    @fldPassvand varchar(100),
    @fldIcon varbinary(MAX),
	@fldSize int,
	@fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldFormatName=Com.fn_TextNormalize(@fldFormatName)
	SET @fldPassvand=Com.fn_TextNormalize(@fldPassvand)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [com].[tblFormatFile]
	SET    [fldFormatName] = @fldFormatName, fldsize=@fldSize,[fldPassvand] = @fldPassvand, [fldIcon] = @fldIcon, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
