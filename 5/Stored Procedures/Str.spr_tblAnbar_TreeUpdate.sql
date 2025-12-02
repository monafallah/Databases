SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbar_TreeUpdate] 
    @fldId int,
    @fldAnbarId int,
    @fldAnbarTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [Str].[tblAnbar_Tree]
	SET    [fldId] = @fldId, [fldAnbarId] = @fldAnbarId, [fldAnbarTreeId] = @fldAnbarTreeId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
