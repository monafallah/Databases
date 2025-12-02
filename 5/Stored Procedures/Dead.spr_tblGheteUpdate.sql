SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGheteUpdate] 
    @fldId int,
    @fldVadiSalamId int,
    @fldNameGhete nvarchar(200),
	@fldorganid int,
    @fldUserId int,
    @fldIP nchar(10),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldNameGhete=com.fn_TextNormalize(@fldNameGhete)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblGhete]
	SET    [fldVadiSalamId] = @fldVadiSalamId,fldorganid=@fldorganid, [fldNameGhete] = @fldNameGhete, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] =getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
