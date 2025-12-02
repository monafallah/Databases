SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblActionsInsert] 
 
    @fldTitleAction nvarchar(300),
    @fldUserId int,
	@fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldTitleAction=com.fn_TextNormalize(@fldTitleAction)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblActions] 

	INSERT INTO [Dead].[tblActions] ([fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId )
	SELECT @fldId, @fldTitleAction, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId 
	if(@@Error<>0)
        rollback       
	COMMIT
GO
