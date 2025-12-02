SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarTreeUpdate] 
    @fldId int,
   
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId INT,
    @fldGroupId int
AS 
	BEGIN TRAN
	UPDATE [Str].[tblAnbarTree]
	SET    [fldId] = @fldId,  [fldName] = @fldName, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId,[fldGroupId]=@fldGroupId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
