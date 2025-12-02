SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudje_khedmatDarsadIdUpdate] 
    @fldBudje_khedmatDarsadId int,
    @fldCodingAcc_detailId int = NULL,
    @fldCodingBudje_DetailsId int = NULL,
    @fldDarsad float = NULL,

    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [BUD].[tblBudje_khedmatDarsadId]
	SET    [fldCodingAcc_detailId] = @fldCodingAcc_detailId, [fldCodingBudje_DetailsId] = @fldCodingBudje_DetailsId, [fldDarsad] = @fldDarsad, [fldDate] = getdate(), [fldUserId] = @fldUserId
	WHERE  [fldBudje_khedmatDarsadId] = @fldBudje_khedmatDarsadId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
