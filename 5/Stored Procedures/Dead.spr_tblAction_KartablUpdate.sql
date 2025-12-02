SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblAction_KartablUpdate] 
    @fldId int,
    @fldActionId int,
    @fldKartablId int,
    @fldUserId int,
	@fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblAction_Kartabl]
	SET    [fldActionId] = @fldActionId, [fldKartablId] = @fldKartablId, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldOrganId=@fldOrganId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
