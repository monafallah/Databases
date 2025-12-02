SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterNumberDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	update Auto.tblLetterNumber
	set fldUserId=@fldUserId,fldDate=getdate()
	where fldid=@fldId
	if (@@error<>0)
		rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblLetterNumber]
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end

	COMMIT TRAN

GO
