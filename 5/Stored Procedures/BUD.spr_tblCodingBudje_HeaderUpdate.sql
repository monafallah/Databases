SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_HeaderUpdate] 
    @fldHeaderId int,
    @fldYear smallint,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [BUD].[tblCodingBudje_Header]
	SET    [fldYear] = @fldYear, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldHedaerId=@fldHeaderId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
