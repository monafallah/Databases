SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblSignerUpdate] 
    @fldID bigint,
    @fldLetterID bigint,
    @fldSignerComisionID int,
    @fldIndexerID int,
    @fldFirstSigner int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
set @fldDesc=com.fn_TextNormalize(@fldDesc)
BEGIN TRAN
UPDATE [Auto].[tblSigner]
	SET  [fldLetterID] = @fldLetterID, [fldSignerComisionID] = @fldSignerComisionID,  [fldIndexerID] = @fldIndexerID, [fldFirstSigner] = @fldFirstSigner, [fldDesc] = @fldDesc
	,fldOrganId=@fldOrganId,fldDate=getdate()
	WHERE  [fldID] = @fldID
IF(@@ERROR<>0)
 ROLLBACK
COMMIT TRAN

GO
