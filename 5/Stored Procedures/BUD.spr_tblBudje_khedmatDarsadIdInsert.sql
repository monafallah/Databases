SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudje_khedmatDarsadIdInsert] 
    @fldCodingAcc_detailId int = NULL,
    @fldCodingBudje_DetailsId int = NULL,
    @fldDarsad float = NULL,
	@Pishbini Bud.Pishbini readonly,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
	merge [BUD].[tblPishbini] as t
		using (select @fldCodingAcc_detailId, @fldCodingBudje_DetailsId,Mablagh ,BudgetTypeId,MotammamId from @Pishbini ) as s(CodingAcc_DetailsId, CodingBudje_DetailsId,Mablagh,BudgetTypeId,MotammamId)
		on(t.fldCodingAcc_DetailsId=s.CodingAcc_DetailsId and (( s.CodingBudje_DetailsId is null and  t.fldCodingBudje_DetailsId is null) or t.fldCodingBudje_DetailsId=s.CodingBudje_DetailsId) and t.fldBudgetTypeId=s.BudgetTypeId) and ((s.MotammamId is null  and t.fldMotammamId is null)or t.fldMotammamId=s.MotammamId)
		WHEN MATCHED
				THEN
					UPDATE
					SET fldMablagh = s.Mablagh,fldUserId=@fldUserId,fldDate=getdate()
		WHEN NOT MATCHED
				THEN
		INSERT   ([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
			values (CodingAcc_DetailsId, CodingBudje_DetailsId, Mablagh, BudgetTypeId, getdate(), @fldUserId,MotammamId);
	if (@@error<>0)
				rollback
	else if(@fldCodingBudje_DetailsId is not null)
	begin
		merge [BUD].[tblBudje_khedmatDarsadId] as t
		using (select @fldCodingAcc_detailId, @fldCodingBudje_DetailsId) as s(CodingAcc_detailId, CodingBudje_DetailsId)
		on(t.fldCodingAcc_detailId=s.CodingAcc_detailId and  t.fldCodingBudje_DetailsId=s.CodingBudje_DetailsId)
			 WHEN MATCHED
				then
					update
					set fldDarsad=@fldDarsad,fldUserId=@fldUserId,fldDate=getdate()
			WHEN NOT MATCHED
				THEN
				INSERT   ([fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId])
				values( CodingAcc_detailId, CodingBudje_DetailsId, @fldDarsad, getdate(), @fldUserId);
			if (@@error<>0)
				rollback
	end
	
		
	
				
               
	COMMIT
GO
