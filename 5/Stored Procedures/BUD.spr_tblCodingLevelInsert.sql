SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingLevelInsert] 

    @fldName nvarchar(300),
    @fldFiscalBudjeId int,
    @fldArghamNum int,
    @fldOrganId int,
    @fldDesc nvarchar(50),
    @fldUserId int,

    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [BUD].[tblCodingLevel] 

	INSERT INTO [BUD].[tblCodingLevel] ([fldId], [fldName], [fldFiscalBudjeId], [fldArghamNum], [fldOrganId], [fldDesc], [fldUserId], [fldDate], [fldIP])
	SELECT @fldId, @fldName, @fldFiscalBudjeId, @fldArghamNum, @fldOrganId, @fldDesc, @fldUserId, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
