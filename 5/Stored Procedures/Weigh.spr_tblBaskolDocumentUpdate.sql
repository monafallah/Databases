SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblBaskolDocumentUpdate] 
    @fldId int,
    @fldTozinId int,
    @fldFileId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),

    @fldIP varchar(15)
AS 

	BEGIN TRAN

	UPDATE [Weigh].[tblBaskolDocument]
	SET    [fldTozinId] = @fldTozinId, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
