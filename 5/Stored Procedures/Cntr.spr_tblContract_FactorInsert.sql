SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContract_FactorInsert] 
 
    @fldContractId int,
    @fldFactorId int,
    @fldUserId int,
    @fldOrganID int,
    @fldIP varchar(15),
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblContract_Factor] 
	INSERT INTO [Cntr].[tblContract_Factor] ([fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldContractId, @fldFactorId, @fldUserId, @fldOrganID, @fldIP, @fldDesc, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
