SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblPishbiniDelete] 
@fieldname nvarchar(50),
    @fldCodingAcc_DetailsId int,
    @fldCodingBudje_DetailsId int = NULL,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	if(@fieldname='Project')
	begin
		UPDATE [BUD].[tblPishbini]
		SET    fldUserId=@fldUserId,fldDate=getdate()
		WHERE  fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId 
		and (( @fldCodingBudje_DetailsId is null and  fldCodingBudje_DetailsId is null) or fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId)
			if (@@error<>0)
			rollback
	
		DELETE
		FROM   [BUD].[tblPishbini]
		WHERE  fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId 
		and (( @fldCodingBudje_DetailsId is null and  fldCodingBudje_DetailsId is null) or fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId)
		if (@@error<>0)
			rollback
	end
	if(@fieldname='Faaliyat')
	begin
		UPDATE [BUD].tblBudje_khedmatDarsadId
		SET    fldUserId=@fldUserId,fldDate=getdate()
		WHERE  fldCodingAcc_detailId=@fldCodingAcc_DetailsId 
		and ( fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId)
			if (@@error<>0)
			rollback
	
		DELETE
		FROM   [BUD].tblBudje_khedmatDarsadId
		WHERE  fldCodingAcc_detailId=@fldCodingAcc_DetailsId 
		and ( fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId)
		if (@@error<>0)
			rollback
	end

	COMMIT
GO
