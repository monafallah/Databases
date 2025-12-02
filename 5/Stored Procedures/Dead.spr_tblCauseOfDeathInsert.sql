SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCauseOfDeathInsert] 
    @fldReason nvarchar(200),
    @fldUserID int,
    @fldDesc nvarchar(100),
    @fldIP varchar(15)
AS 

	
	BEGIN TRAN
	set @fldReason=com.fn_TextNormalize(@fldReason)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblCauseOfDeath] 

	INSERT INTO [Dead].[tblCauseOfDeath] ([fldId], [fldReason], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldId, @fldReason, GETDATE(), @fldUserID, @fldDesc, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
