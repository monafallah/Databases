SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblPishbiniUpdate] 
    @fldpishbiniId int,
    @fldCodingAcc_DetailsId int,
    @fldCodingBudje_DetailsId int = NULL,
    @fldMablagh bigint,
    @fldBudgetTypeId int,
	@fldMotammamId  int,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [BUD].[tblPishbini]
	SET    [fldCodingAcc_DetailsId] = @fldCodingAcc_DetailsId, [fldCodingBudje_DetailsId] = @fldCodingBudje_DetailsId, [fldMablagh] = @fldMablagh, [fldBudgetTypeId] = @fldBudgetTypeId, [fldDate] = getdate(), [fldUserId] = @fldUserId
	,fldMotammamId=@fldMotammamId
	WHERE  [fldpishbiniId] = @fldpishbiniId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
