SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeFieldTypesInsert] 
    @fldFaName nvarchar(300),
    @fldEnName varchar(400),
    @fldOrganId int,
	@fldUserId int,
    @fldType bit
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldFaName=com.fn_TextNormalize(@fldFaName)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Auto].[tblMergeFieldTypes] 
	INSERT INTO [Auto].[tblMergeFieldTypes] ([fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate], [fldType],fldUserId)
	SELECT @fldId, @fldFaName, @fldEnName, @fldOrganId, getdate(), @fldType,@fldUserId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
