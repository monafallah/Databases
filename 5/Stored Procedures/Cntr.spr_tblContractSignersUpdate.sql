SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractSignersUpdate] 
    @fldId int,
    @fldContractId int,
    @fldCompanyPostId smallint,
    @fldEmpolyId int,
    @fldPostEjraeeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(150)
AS 

	BEGIN TRAN

	UPDATE [Cntr].[tblContractSigners]
	SET    [fldContractId] = @fldContractId, [fldCompanyPostId] = @fldCompanyPostId, [fldEmpolyId] = @fldEmpolyId, [fldPostEjraeeId] = @fldPostEjraeeId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
