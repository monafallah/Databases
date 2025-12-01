SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketPermissionUpdate] 
    @fldId int,
    @fldCategoryId int,
    @fldTicketUserId int,
    @fldSee bit,
    @fldAnswer bit,
  
    @fldDesc nvarchar(MAX),
	@fldInputId INT 
AS 
	BEGIN TRAN
	UPDATE [dbo].[tblTicketPermission]
	SET    [fldCategoryId] = @fldCategoryId, [fldTicketUserId] = @fldTicketUserId, [fldSee] = @fldSee, [fldAnswer] = @fldAnswer, [fldDesc] = @fldDesc
	
	WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
	
	rollback
	
	
	COMMIT TRAN
GO
