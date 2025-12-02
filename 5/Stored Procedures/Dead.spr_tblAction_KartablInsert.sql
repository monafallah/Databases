SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblAction_KartablInsert] 
  
    @fldActionId int,
    @fldKartablId int,
    @fldUserId int,
	@fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblAction_Kartabl] 

	INSERT INTO [Dead].[tblAction_Kartabl] ([fldId], [fldActionId], [fldKartablId], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId )
	SELECT @fldId, @fldActionId, @fldKartablId, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId 
	if(@@Error<>0)
        rollback       
	COMMIT
GO
