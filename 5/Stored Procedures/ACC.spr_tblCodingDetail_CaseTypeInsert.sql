SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCodingDetail_CaseTypeInsert] 
 
    @fldCodingDetailId int,
    @fldCaseTypeId int,
    @fldUserId int,
    @fldIP varchar(15)
	 
	as
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [ACC].[tblCodingDetail_CaseType] 
	INSERT INTO [ACC].[tblCodingDetail_CaseType] ([fldId], [fldCodingDetailId], [fldCaseTypeId], [fldUserId], [fldIP], [fldDate])
	SELECT @fldId, @fldCodingDetailId, @fldCaseTypeId, @fldUserId, @fldIP, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
