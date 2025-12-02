SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecorde_FileInsert] 
   
    @fldDocumentHeaderId int,
    @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(100),
	@fldIP varchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@fileId int
	select @fileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	if (@@error<>0)
		rollback
	else
	begin


	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecorde_File] 
	INSERT INTO [ACC].[tblDocumentRecorde_File] ([fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate],fldIP)
	SELECT @fldId, @fldDocumentHeaderId, @fileId, @fldUserId, @fldDesc, getdate(),@fldIP
	if(@@Error<>0)
        rollback
	end	       
	COMMIT
GO
