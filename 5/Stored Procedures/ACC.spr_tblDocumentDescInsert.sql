SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentDescInsert] 
    @fldName nvarchar(200),
    @fldDocDesc nvarchar(MAX),
    @fldDesc nvarchar(MAX),
	@fldFlag bit,
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDocDesc=Com.fn_TextNormalize(@fldDocDesc)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentDesc] 
	INSERT INTO [ACC].[tblDocumentDesc] ([fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId],fldFlag)
	SELECT @fldId, @fldName, @fldDocDesc, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldFlag
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
