SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarGroupInsert] 
    
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblAnbarGroup] 
	INSERT INTO [Str].[tblAnbarGroup] ([fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldName, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
