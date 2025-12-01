SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketPermissionInsert] 
   
    @fldCategoryId int,
    @fldTicketUserId int,
    @fldSee bit,
    @fldAnswer bit,
    
    @fldDesc nvarchar(100),
	@fldInputId INT 
AS 
	
	BEGIN TRAN
	declare @fldID int 
	sET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTicketPermission] 
	INSERT INTO [dbo].[tblTicketPermission] ([fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer], [fldDesc])
	SELECT @fldId, @fldCategoryId, @fldTicketUserId, @fldSee, @fldAnswer, @fldDesc
	IF(@@ERROR<>0)
	BEGIN
		
		ROLLBACK
	END
	
	COMMIT
GO
