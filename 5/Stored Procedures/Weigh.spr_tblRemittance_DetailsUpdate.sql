SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_DetailsUpdate] 
    @fldId int,
    @fldRemittanceId int,
    @fldKalaId int,
    @fldMaxTon int,
    @fldControlLimit bit,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),

    @fldIP varchar(15)
AS 

	BEGIN TRAN

	UPDATE [Weigh].[tblRemittance_Details]
	SET    [fldRemittanceId] = @fldRemittanceId, [fldKalaId] = @fldKalaId, [fldMaxTon] = @fldMaxTon, [fldControlLimit] = @fldControlLimit, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
