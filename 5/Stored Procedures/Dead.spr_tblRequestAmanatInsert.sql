SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRequestAmanatInsert] 
   
    @fldEmployeeId int,
    @fldShomareId int,
	
    @fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	
	declare @fldID int ,@fldTarikh int
	set @fldTarikh=replace(dbo.Fn_AssembelyMiladiToShamsi(getdate()),'/','')
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblRequestAmanat] 

	INSERT INTO [Dead].[tblRequestAmanat] ([fldId], [fldEmployeeId], [fldShomareId], [fldOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate],fldTarikh,fldIsEbtal)
	SELECT @fldId, @fldEmployeeId, @fldShomareId, @fldOrganId, @fldUserId, @fldIP, @fldDesc, getdate(),@fldTarikh,0
	if(@@Error<>0)
        rollback       
	COMMIT
GO
