SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMotammamInsert] 
 
    @fldFiscalYearId int,
    @fldTarikh varchar(10),
    @fldDesc nvarchar(MAX),
    @fldUserId int,
    @fldOrganId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldid=isnull(max(fldId),0)+1  FROM   [BUD].[tblMotammam] 
	INSERT INTO [BUD].[tblMotammam] ([fldId], [fldFiscalYearId], [fldTarikh], [fldDesc], [fldUserId], [fldOrganId], [fldDate])
	SELECT @fldId, @fldFiscalYearId, @fldTarikh, @fldDesc, @fldUserId, @fldOrganId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
