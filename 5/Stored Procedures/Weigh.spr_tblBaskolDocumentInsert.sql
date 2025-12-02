SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblBaskolDocumentInsert] 
  
    @fldTozinId int,
    @fldFileId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP varchar(15)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblBaskolDocument] 

	INSERT INTO [Weigh].[tblBaskolDocument] ([fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldTozinId, @fldFileId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
