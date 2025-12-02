SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_HeaderUpdate] 
    @fldId int,
    @fldArchiveNum NVARCHAR(50),
    @fldDescriptionDocu nvarchar(MAX),
    @fldOrganId INT,
    @fldTarikhDocument CHAR(10),
    @fldDesc nvarchar(MAX),
   
    @fldIP varchar(16),
    @fldUserId int,
	@fldAccept tinyint,
	@fldType tinyint
AS 
	BEGIN TRAN
	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @logId int
	--UPDATE [ACC].[tblDocumentRecord_Header]
	--SET    [fldId] = @fldId, [fldArchiveNum] = @fldArchiveNum, [fldDescriptionDocu] = @fldDescriptionDocu,[fldOrganId]=@fldOrganId,[fldTarikhDocument]=@fldTarikhDocument, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId,[fldAccept]=@fldAccept
	--,fldType=@fldType
	--WHERE  [fldId] = @fldId
	update [ACC].[tblDocumentRecord_Header]
	set @fldAccept=1 
	where fldid=@fldId
	if (@@ERROR<>0)
		rollback
	else
	begin
		select @logId =ISNULL(max(fldId),0)+1 from [ACC].tblDocument_HeaderLog
		insert into Acc.tblDocument_HeaderLog(fldid,fldHeaderId,fldUserId,fldDate)
		select+@logId,@fldid,@fldUserId,getdate() 
		if (@@ERROR<>0)
			rollback	
	end
	COMMIT TRAN

GO
