SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCauseOfDeathUpdate] 
    @fldId int,
    @fldReason nvarchar(200),
    @fldUserID int,
    @fldDesc nvarchar(100),
    @fldIP varchar(15)
AS 

	BEGIN TRAN
	set @fldReason=com.fn_TextNormalize(@fldReason)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblCauseOfDeath]
	SET    [fldReason] = @fldReason, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
