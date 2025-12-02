SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarGroupUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [Str].[tblAnbarGroup]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
