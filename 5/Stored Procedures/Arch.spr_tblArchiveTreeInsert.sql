SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblArchiveTreeInsert] 
	@fldID int out,
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
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblArchiveTree] 
	INSERT INTO [Arch].[tblArchiveTree] ([fldId], [fldPID], [fldTitle], [fldFileUpload], [fldUserId], [fldDesc], [fldDate],fldOrganId,fldModuleId)
	SELECT @fldId, @fldPID, @fldTitle, @fldFileUpload, @fldUserId, @fldDesc, GETDATE(),@fldOrganId,@fldModuleId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
