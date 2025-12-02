SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKala_TreeInsert] 
    
    @fldKalaId int,
    @fldKalaTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from com.[tblKala_Tree] 
	INSERT INTO com.[tblKala_Tree] ([fldId], [fldKalaId], [fldKalaTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrganId)
	SELECT @fldId, @fldKalaId, @fldKalaTreeId, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
