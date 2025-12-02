SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTamdidUpdate] 
    @fldId int,
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

	UPDATE [Cntr].[tblTamdid]
	SET    [fldContractId] = @fldContractId, [fldTamdidTypeId] = @fldTamdidTypeId, [fldTarikhPayan] = @fldTarikhPayan, [fldMablaghAfzayeshi] = @fldMablaghAfzayeshi, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
