SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartabl_RequestInsert] 
    
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
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblKartabl_Request] 

	INSERT INTO [Dead].[tblKartabl_Request] ([fldId], [fldKartablId], [fldActionId], [fldRequestId],fldKartablNextId, [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate],fldEtmamCharkhe)
	SELECT @fldId, @fldKartablId, @fldActionId, @fldRequestId,@fldKartablNextId, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate(),0
	if(@@Error<>0)
        rollback       
	COMMIT
GO
