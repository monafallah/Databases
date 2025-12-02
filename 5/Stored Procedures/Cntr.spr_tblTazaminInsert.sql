SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTazaminInsert] 
 
    @fldContractId int,
    @fldWarrantyTypeId int,
    @fldTypeTamdid bit,
    @fldSepamNum nvarchar(50),
    @fldTarikh varchar(10),
    @fldMablagh bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cntr].[tblTazamin] 

	INSERT INTO [Cntr].[tblTazamin] ([fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], [fldTarikh], [fldMablagh], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldContractId, @fldWarrantyTypeId, @fldTypeTamdid, @fldSepamNum, @fldTarikh, @fldMablagh, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
