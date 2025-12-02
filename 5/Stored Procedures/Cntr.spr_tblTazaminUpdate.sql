SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTazaminUpdate] 
    @fldId int,
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

	UPDATE [Cntr].[tblTazamin]
	SET    [fldContractId] = @fldContractId, [fldWarrantyTypeId] = @fldWarrantyTypeId, [fldTypeTamdid] = @fldTypeTamdid, [fldSepamNum] = @fldSepamNum, [fldTarikh] = @fldTarikh, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
