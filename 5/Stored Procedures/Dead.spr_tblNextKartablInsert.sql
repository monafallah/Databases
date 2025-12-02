SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextKartablInsert] 
   
    @fldKartablNextId int,
    @fldActionId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),

    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblNextKartabl] 

	INSERT INTO [Dead].[tblNextKartabl] ([fldId], [fldKartablNextId], [fldActionId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldKartablNextId, @fldActionId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
