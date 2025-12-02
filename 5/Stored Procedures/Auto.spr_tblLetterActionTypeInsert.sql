SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionTypeInsert] 
   
    @fldTitleActionType nvarchar(200),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldTitleActionType=com.fn_TextNormalize(@fldTitleActionType)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterActionType] 

	INSERT INTO [Auto].[tblLetterActionType] ([fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldTitleActionType, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
