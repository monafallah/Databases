SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblArchiveTreeUpdate] 
    @fldId int,
    @fldPID int = NULL,
    @fldTitle nvarchar(300) = NULL,
    @fldFileUpload bit = NULL,
	@fldOrganId int,
	@fldModuleId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Arch].[tblArchiveTree]
	SET    [fldPID] = @fldPID, [fldTitle] = @fldTitle, [fldFileUpload] = @fldFileUpload, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldOrganId=@fldOrganId ,fldModuleId=@fldModuleId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
