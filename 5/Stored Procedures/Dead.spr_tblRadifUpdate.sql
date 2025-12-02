SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRadifUpdate] 
    @fldId int,
    @fldGheteId int,
    @fldNameRadif nvarchar(250),
	@fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldNameRadif=com.fn_TextNormalize(@fldNameRadif)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblRadif]
	SET    [fldGheteId] = @fldGheteId, [fldNameRadif] = @fldNameRadif, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldOrganId=@fldOrganId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
