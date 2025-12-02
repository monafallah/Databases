SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatDaraeiDelete] 
   @fldYear smallint,
    @fldMonth tinyint,
	@fldNobatePardakht tinyint,
    @fldOrganId int,
    @fldUserId int,
    @fldIp varchar(15)
AS 
	
	
	BEGIN TRAN
	UPDATE [Pay].[tblMaliyatDaraei]
	SET     [fldUserId] = @fldUserId, [fldIp] = @fldIp, [fldDate] = getdate()
	WHERE  [fldYear] = @fldYear and  [fldMonth] = @fldMonth and  [fldNobatePardakht] = @fldNobatePardakht and [fldOrganId] = @fldOrganId
	
	DELETE
	FROM   [Pay].[tblMaliyatDaraei]
	WHERE  [fldYear] = @fldYear and  [fldMonth] = @fldMonth and  [fldNobatePardakht] = @fldNobatePardakht and [fldOrganId] = @fldOrganId
	if (@@error<>0)
		rollback
	COMMIT
GO
