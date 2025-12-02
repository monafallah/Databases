SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_DetailsInsert] 
   
    @fldDocument_HedearId int,
    @fldCodingId int,
    @fldDescription nvarchar(MAX),
    @fldBedehkar bigint,
    @fldBestankar bigint,
    @fldCenterCoId int,
    @fldCaseTypeId int,
	@fldSourceId int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrder smallint
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fldCaseId int
	if(@fldSourceId<>0)
	begin
		select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
		INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
		SELECT @fldCaseId, @fldCaseTypeId, @fldSourceId, '', GETDATE(), @fldIP, @fldUserId
		if (@@ERROR<>0)
			ROLLBACK
	end
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
	INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
	SELECT @fldId, @fldDocument_HedearId, @fldCodingId, @fldDescription, @fldBedehkar, @fldBestankar, @fldCenterCoId, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldOrder
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
