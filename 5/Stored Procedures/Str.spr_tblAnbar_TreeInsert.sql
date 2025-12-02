SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbar_TreeInsert] 
    
    @fldAnbarId int,
    @fldAnbarTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblAnbar_Tree] 
	INSERT INTO [Str].[tblAnbar_Tree] ([fldId], [fldAnbarId], [fldAnbarTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldAnbarId, @fldAnbarTreeId, @fldDesc,GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
