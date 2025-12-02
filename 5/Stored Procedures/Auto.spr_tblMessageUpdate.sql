SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageUpdate] 
    @fldId int,
    @fldCommisionId int,
    @fldTitle nvarchar(50),
    @fldMatn nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
  
    @fldOrganId int,
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
	set @fldMatn=com.fn_TextNormalize(@fldMatn)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	UPDATE [Auto].[tblMessage]
	SET    [fldCommisionId] = @fldCommisionId, [fldTitle] = @fldTitle, [fldMatn] = @fldMatn, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
