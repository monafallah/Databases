SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesabCodeDaramadInsert] 

    @fldShomareHesadId int,
    @fldCodeDaramadId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShorooshenaseGhabz tinyint
	
	
AS 
	
	BEGIN TRAN
	declare @sal smallint=SUBSTRING(dbo.Fn_AssembelyMiladiToShamsi(cast(getdate() as date)),1,4)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblShomareHesabCodeDaramad] 
	INSERT INTO [Drd].[tblShomareHesabCodeDaramad] ([fldId], [fldShomareHesadId], [fldCodeDaramadId],[fldOrganId],[fldUserId], [fldDesc], [fldDate],fldShorooshenaseGhabz,fldFormulMohasebatId, fldFormulKoliId,fldReportFileId,fldFormolsaz,fldSharhCodDaramd,fldstatus)
	SELECT @fldId, @fldShomareHesadId, @fldCodeDaramadId, @fldOrganId, @fldUserId, @fldDesc, GETDATE(),@fldShorooshenaseGhabz, null,null,null,null,NULL,1
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		update drd.tblShomareHedabCodeDaramd_Detail
		set fldEndYear=@sal
		where fldCodeDaramdId=@fldCodeDaramadId
		if (@@error<>0)
			rollback
	end
	COMMIT
GO
