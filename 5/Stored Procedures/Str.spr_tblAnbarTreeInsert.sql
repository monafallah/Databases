SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarTreeInsert] 
    
    @fldPID INT,
   
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId INT,
     @fldGroupId INT
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblAnbarTree] 
	INSERT INTO [Str].[tblAnbarTree] ([fldId], [fldPID] ,[fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],[fldGroupId])


	SELECT @fldId, @fldPID ,@fldName, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldGroupId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
