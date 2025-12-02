SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContract_FactorUpdate] 
    @fldId int,
    @fldContractId int,
    @fldFactorId int,
    @fldUserId int,
    @fldOrganID int,
    @fldIP varchar(15),
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Cntr].[tblContract_Factor]
	SET    [fldContractId] = @fldContractId, [fldFactorId] = @fldFactorId, [fldUserId] = @fldUserId, [fldOrganID] = @fldOrganID, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
