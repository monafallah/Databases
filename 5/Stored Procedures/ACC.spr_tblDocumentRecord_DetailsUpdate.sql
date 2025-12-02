SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_DetailsUpdate] 
    @fldId int,
    @fldDocument_HedearId int,
    @fldCodingId int,
    @fldDescription nvarchar(MAX),
    @fldBedehkar bigint,
    @fldBestankar bigint,
    @fldCenterCoId int,
    @fldCaseId int,
	@fldCaseTypeId int,
	@fldSourceId int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrder smallint
AS 
	BEGIN TRAN
	
	if(@fldSourceId<>0 and @fldCaseId=0)
	begin
		select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
		INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
		SELECT @fldCaseId, @fldCaseTypeId, @fldSourceId, '', GETDATE(), @fldIP, @fldUserId
		if (@@ERROR<>0)
			ROLLBACK
	end
	if(@fldSourceId<>0 and @fldCaseId<>0)
	begin
		UPDATE [ACC].[tblCase]
	SET    [fldCaseTypeId] = @fldCaseTypeId, [fldSourceId] = @fldSourceId, [fldDesc] = '', [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
		if (@@ERROR<>0)
			ROLLBACK
	end
	SET @fldDescription=Com.fn_TextNormalize(@fldDescription)

	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblDocumentRecord_Details]
	SET    [fldId] = @fldId, [fldDocument_HedearId] = @fldDocument_HedearId, [fldCodingId] = @fldCodingId, [fldDescription] = @fldDescription, [fldBedehkar] = @fldBedehkar, [fldBestankar] = @fldBestankar, [fldCenterCoId] = @fldCenterCoId, [fldCaseId] = @fldCaseId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldOrder=@fldOrder
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
