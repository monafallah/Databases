SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblParticularPropertiesInsert] 
  
    @fldArchiveTreeId int,
    @fldPropertiesId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblParticularProperties] 
	INSERT INTO [Arch].[tblParticularProperties] ([fldId], [fldArchiveTreeId], [fldPropertiesId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldArchiveTreeId, @fldPropertiesId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
