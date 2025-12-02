SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTamdidInsert] 
    
    @fldContractId int,
    @fldTamdidTypeId tinyint,
    @fldTarikhPayan varchar(10),
    @fldMablaghAfzayeshi bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cntr].[tblTamdid] 

	INSERT INTO [Cntr].[tblTamdid] ([fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldContractId, @fldTamdidTypeId, @fldTarikhPayan, @fldMablaghAfzayeshi, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
