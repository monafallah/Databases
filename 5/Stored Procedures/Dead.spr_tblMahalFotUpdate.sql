SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMahalFotUpdate] 
    @fldId int,
    @fldNameMahal nvarchar(250),
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldNameMahal=com.fn_TextNormalize(@fldNameMahal)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblMahalFot]
	SET    [fldNameMahal] = @fldNameMahal, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
