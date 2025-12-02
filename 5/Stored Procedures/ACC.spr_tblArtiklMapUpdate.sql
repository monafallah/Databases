SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblArtiklMapUpdate] 
    @fldId int,
    @fldBankBillId int,
    @fldDocumentRecord_DetailsId int,
	@fldType	tinyint,
	@fldSourceId	varchar(MAX)	,    
    @fldIP varchar(16),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [ACC].[tblArtiklMap]
	SET    [fldBankBillId] = @fldBankBillId, [fldDocumentRecord_DetailsId] = @fldDocumentRecord_DetailsId, [fldDate] = getdate(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldType=@fldType,fldSourceId=@fldSourceId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
