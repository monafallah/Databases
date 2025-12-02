SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblActionsUpdate] 
    @fldId int,
    @fldTitleAction nvarchar(300),
    @fldUserId int,
	@fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldTitleAction=com.fn_TextNormalize(@fldTitleAction)
	UPDATE [Dead].[tblActions]
	SET    [fldTitleAction] = @fldTitleAction, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldOrganId =@fldOrganId 
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
