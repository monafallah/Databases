SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCodingDetail_CaseTypeUpdate] 
    @fldId int,
    @fldCodingDetailId int,
    @fldCaseTypeId int,
    @fldUserId int,
    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN

	UPDATE [ACC].[tblCodingDetail_CaseType]
	SET    [fldCodingDetailId] = @fldCodingDetailId, [fldCaseTypeId] = @fldCaseTypeId, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
