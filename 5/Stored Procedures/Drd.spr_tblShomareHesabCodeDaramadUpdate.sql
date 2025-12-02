SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesabCodeDaramadUpdate] 
    @fldId int,
    @fldShomareHesadId int,
    @fldCodeDaramadId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShorooshenaseGhabz tinyint
	

AS 
	BEGIN TRAN
	declare @sal smallint =SUBSTRING(dbo.Fn_AssembelyMiladiToShamsi (cast((getdate())as date)),1,4)
	UPDATE [Drd].[tblShomareHesabCodeDaramad]
	SET    [fldId] = @fldId, [fldShomareHesadId] = @fldShomareHesadId, [fldCodeDaramadId] = @fldCodeDaramadId, [fldOrganId] = @fldOrganId,[fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldShorooshenaseGhabz=@fldShorooshenaseGhabz
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT TRAN
GO
