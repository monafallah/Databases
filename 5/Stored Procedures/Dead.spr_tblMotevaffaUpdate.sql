SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMotevaffaUpdate] 
    @fldId int,
    @fldCauseOfDeathId int,
    @fldGhabreAmanatId int,
    @fldTarikhFot int,
    @fldTarikhDafn int ,
	@fldMahalFotId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN

	UPDATE [Dead].[tblMotevaffa]
	SET    [fldCauseOfDeathId] = @fldCauseOfDeathId, [fldGhabreAmanatId] = @fldGhabreAmanatId, [fldTarikhFot] = @fldTarikhFot, [fldTarikhDafn] = @fldTarikhDafn, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP
	,fldMahalFotId=@fldMahalFotId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
