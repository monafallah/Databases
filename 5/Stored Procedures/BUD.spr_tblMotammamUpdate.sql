SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMotammamUpdate] 
    @fldId int,
    @fldFiscalYearId int,
    @fldTarikh varchar(10),
    @fldDesc nvarchar(MAX),
    @fldUserId int,
    @fldOrganId int
AS 
	 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [BUD].[tblMotammam]
	SET    [fldFiscalYearId] = @fldFiscalYearId, [fldTarikh] = @fldTarikh, [fldDesc] = @fldDesc, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
