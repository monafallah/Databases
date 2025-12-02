SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRequestAmanatUpdate] 
    @fldId int,
    @fldEmployeeId int,
    @fldShomareId int,
	
    @fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	declare @fldTarikh int
		--set @fldTarikh=replace(dbo.Fn_AssembelyMiladiToShamsi(getdate()),'/','')
	UPDATE [Dead].[tblRequestAmanat]
	SET    [fldEmployeeId] = @fldEmployeeId, [fldShomareId] = @fldShomareId, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	--,fldTarikh=@fldTarikh
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
