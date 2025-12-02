SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetter_MergeFieldTypeInsert] 
    
    @fldLetterId bigint,
    @fldMergeTypeId int,
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Auto].[tblLetter_MergeFieldType] 
	INSERT INTO [Auto].[tblLetter_MergeFieldType] ([fldId], [fldLetterId], [fldMergeTypeId],fldValue, [fldUserId], [fldOrganId], [fldDesc], [fldDate])
	SELECT @fldId, @fldLetterId, @fldMergeTypeId,@fldValue, @fldUserId, @fldOrganId, @fldDesc, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
