SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblFormatFileInsert] 
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
	declare @fldID tinyint 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblFormatFile] 
	INSERT INTO [com].[tblFormatFile] ([fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate],fldSize,fldOrganId)
	SELECT @fldId, @fldFormatName, @fldPassvand, @fldIcon, @fldUserId, @fldDesc, GETDATE(),@fldSize,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
