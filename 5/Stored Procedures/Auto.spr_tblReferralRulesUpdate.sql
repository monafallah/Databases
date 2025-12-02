SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReferralRulesUpdate] 
    @fldId int,
    @fldPostErjaDahandeId int,
    @fldPostErjaGirandeId int,
	@fldChartEjraeeGirandeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP nvarchar(15),
   
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblReferralRules]
	SET    [fldPostErjaDahandeId] = @fldPostErjaDahandeId, [fldPostErjaGirandeId] = @fldPostErjaGirandeId,fldChartEjraeeGirandeId=@fldChartEjraeeGirandeId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDate] = getdate(), [fldDesc] = @fldDesc
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
