SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextActionUpdate] 
    @fldId int,
    @fldAction_NextId int,
    @fldKartablId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblNextAction]
	SET    [fldAction_NextId] = @fldAction_NextId, [fldKartablId] = @fldKartablId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
