SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeFieldTypesUpdate] 
    @fldId int,
    @fldFaName nvarchar(300),
    @fldEnName varchar(400),
    @fldOrganId int,
   @fldUserId int,
    @fldType bit
AS 
	 
	
	BEGIN TRAN
	set @fldFaName=com.fn_TextNormalize(@fldFaName)
	UPDATE [Auto].[tblMergeFieldTypes]
	SET    [fldFaName] = @fldFaName, [fldEnName] = @fldEnName, [fldOrganId] = @fldOrganId, [fldDate] = getdate(), [fldType] = @fldType
	,fldUserId=@fldUserId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
