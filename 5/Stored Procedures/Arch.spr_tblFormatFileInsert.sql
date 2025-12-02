SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFormatFileInsert] 
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblFormatFile] 
	INSERT INTO [Arch].[tblFormatFile] ([fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldFormatName, @fldPassvand, @fldIcon, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
