SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextActionInsert] 
 
    @fldAction_NextId int,
    @fldKartablId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblNextAction] 

	INSERT INTO [Dead].[tblNextAction] ([fldId], [fldAction_NextId], [fldKartablId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldAction_NextId, @fldKartablId, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
