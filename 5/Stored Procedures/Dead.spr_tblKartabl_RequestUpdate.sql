SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartabl_RequestUpdate] 
    @fldId int,
    @fldKartablId int,
    @fldActionId int,
    @fldRequestId int,
	@fldKartablNextId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN

	UPDATE [Dead].[tblKartabl_Request]
	SET    [fldKartablId] = @fldKartablId, [fldActionId] = @fldActionId, [fldRequestId] = @fldRequestId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldKartablNextId=@fldKartablNextId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
