SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaTreeInsert] 
    
    @fldPID int,
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId INT,
    @fldGroupId int,
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblKalaTree] 
	INSERT INTO [com].[tblKalaTree] ([fldId], [fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],[fldGroupId ],fldOrganId )
	SELECT @fldId, @fldPID, @fldName, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldGroupId ,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
