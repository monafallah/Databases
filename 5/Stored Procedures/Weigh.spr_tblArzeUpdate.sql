SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArzeUpdate] 
    @fldId int,
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

	UPDATE [Weigh].[tblArze]
	SET    [fldBaskoolId] = @fldBaskoolId, [fldKalaId] = @fldKalaId, [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	,fldTedad=@fldTedad,@fldMablagh=@fldMablagh,fldStatusForoosh=@fldStatusForoosh,fldVaznVahed=@fldVaznVahed
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
