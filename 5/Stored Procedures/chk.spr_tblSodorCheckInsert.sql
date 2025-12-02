SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblSodorCheckInsert] 
  
  @fldID int out,
    @fldIdDasteCheck int,
    @fldTarikhVosol nvarchar(10),
    @fldAshkhasId int,
    @fldCodeSerialCheck nvarchar(50),
    @fldBabat nvarchar(MAX),
    @fldBabatFlag bit,
    @fldMablagh BIGINT,
	  @fldFactorId int = NULL,
    @fldContractId int = NULL,
    @fldTankhahGroupId int=NULL,
    @fldDesc nvarchar(MAX),
	@fldUserId INT,
	@fldOrganId int

AS 
	
	BEGIN TRAN
	set @fldBabat =com.fn_TextNormalize(@fldBabat)
	set @fldBabatFlag =com.fn_TextNormalize(@fldBabatFlag)
	declare /*@fldID int ,*/@idch_f int
	select @fldID =ISNULL(max(fldId),0)+1 from [chk].[tblSodorCheck] 
	INSERT INTO [chk].[tblSodorCheck] ([fldId], [fldIdDasteCheck], [fldTarikhVosol],fldAshkhasId, [fldCodeSerialCheck], [fldBabat], [fldBabatFlag], [fldMablagh], [fldDesc], [fldDate],fldUserId,fldOrganId)
	SELECT @fldId, @fldIdDasteCheck, @fldTarikhVosol,@fldAshkhasId , @fldCodeSerialCheck, @fldBabat, @fldBabatFlag, @fldMablagh, @fldDesc, getdate(),@fldUserId,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin 
	if (@fldFactorId is not null or @fldContractId is not null or @fldTankhahGroupId is not null)
		begin 
			select @idch_f=isnull(max(fldId),0)+1  FROM   [chk].[tblCheck_Factor] 
			INSERT INTO [chk].[tblCheck_Factor] ([fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId])
			SELECT @idch_f, @fldId, @fldFactorId, @fldContractId, @fldTankhahGroupId, getdate(), @fldUserId
			if (@@ERROR<>0)
				ROLLBACK
		end 
	end 


	/*declare @shoamrehesabid int
	select @shoamrehesabid=fldIdShomareHesab from chk.tblDasteCheck where fldid=@fldIdDasteCheck

	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCheck] 
	INSERT INTO [Drd].[tblCheck] ([fldId], [fldShomareHesabId], [fldShomareSanad],fldReplyTaghsitId ,[fldTarikhSarResid], [fldMablaghSanad], [fldStatus], [fldTypeSanad], [fldUserId], [fldDesc], [fldDate],fldShomareHesabIdOrgan,fldTarikhAkhz,fldAshkhasId,fldBabat,fldBabatFlag,fldIdDasteCheck,fldOrganId)
	SELECT @fldId, @shoamrehesabid, @fldCodeSerialCheck,NULL ,@fldTarikhVosol, @fldMablagh,1, 0, @fldUserId, @fldDesc, GETDATE(),NULL,dbo.Fn_AssembelyMiladiToShamsi(GETDATE()),@fldAshkhasId,@fldBabat,@fldBabatFlag,@fldIdDasteCheck,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK


declare @id int 
		select @id =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
		INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
		SELECT @id, @fldid, NULL, NULL, 1,dbo.Fn_AssembelyMiladiToShamsi(getdate()),  @fldUserId, N'اینزرت چک', GETDATE()
		if (@@ERROR<>0)
			ROLLBACK*/
	COMMIT
GO
