SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReferralRulesInsert] 
  
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblReferralRules] 

	INSERT INTO [Auto].[tblReferralRules] ([fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, [fldUserId], [fldOrganId], [fldIP], [fldDate], [fldDesc])
	SELECT @fldId, @fldPostErjaDahandeId, @fldPostErjaGirandeId,@fldChartEjraeeGirandeId, @fldUserId, @fldOrganId, @fldIP, getdate(), @fldDesc
	if(@@Error<>0)
        rollback       
	COMMIT
GO
