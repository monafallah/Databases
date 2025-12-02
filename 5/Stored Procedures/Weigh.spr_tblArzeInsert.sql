SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArzeInsert] 
	 @fldID int out,
    @fldBaskoolId int,
    @fldKalaId int,
    @fldShomareHesabCodeDaramadId int,
	@fldTedad tinyint,
	@fldMablagh bigint,
	@fldStatusForoosh tinyint,
	@fldVaznVahed int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    
    @fldIP varchar(16)
AS 

	
	BEGIN TRAN
	

	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblArze] 

	INSERT INTO [Weigh].[tblArze] ([fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldTedad,fldMablagh,fldStatusForoosh,fldVaznVahed)
	SELECT @fldId, @fldBaskoolId, @fldKalaId, @fldShomareHesabCodeDaramadId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP,@fldTedad,@fldMablagh,@fldStatusForoosh,@fldVaznVahed
	if(@@Error<>0)
        rollback       
	COMMIT
GO
