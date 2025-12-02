SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorMostaghelInsert] 
    
    @fldFactorId int,
    @fldAshkhasId int,
    @fldBudjeCodingId int,
    @fldTankhahId int = NULL,
    @fldUserId int,
    @fldOrganID int,
    @fldIP varchar(16),
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblFactorMostaghel] 
	INSERT INTO [Cntr].[tblFactorMostaghel] ([fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldTankhahGroupId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldFactorId, @fldAshkhasId, @fldBudjeCodingId, @fldTankhahId, @fldUserId, @fldOrganID, @fldIP, @fldDesc, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
