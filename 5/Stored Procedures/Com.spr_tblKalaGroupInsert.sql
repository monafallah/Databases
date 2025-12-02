SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaGroupInsert] 
    
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int,
@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from com.[tblKalaGroup] 
	INSERT INTO com.[tblKalaGroup] ([fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrganId)
	SELECT @fldId, @fldName, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldorganId 
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
