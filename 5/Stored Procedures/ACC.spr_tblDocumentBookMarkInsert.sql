SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentBookMarkInsert] 

    @fldDocumentRecordeId int,
    @fldArchiveTreeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
 
    @fldIP varchar(16)
AS 

	
	BEGIN TRAN
	
	declare @fldID int ,@Document_HedearId int=0,@Organ int=0

	select @Document_HedearId=h1.fldDocument_HedearId from acc.tblDocumentRecord_Header1  as h1
	where h1.fldId=@fldDocumentRecordeId

	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentBookMark] 

	INSERT INTO [ACC].[tblDocumentBookMark] ([fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @Document_HedearId, @fldArchiveTreeId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
