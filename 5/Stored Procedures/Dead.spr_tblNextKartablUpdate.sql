SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextKartablUpdate] 
    @fldId int,
    @fldKartablNextId int,
    @fldActionId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblNextKartabl]
	SET    [fldKartablNextId] = @fldKartablNextId, [fldActionId] = @fldActionId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
