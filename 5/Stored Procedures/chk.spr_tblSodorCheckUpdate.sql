SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblSodorCheckUpdate] 
    @fldId int,
    @fldIdDasteCheck int,
    @fldTarikhVosol nvarchar(10),
    @fldAshkhasId int,
    @fldCodeSerialCheck nvarchar(50),
    @fldBabat nvarchar(MAX),
    @fldBabatFlag bit,
    @fldMablagh bigint,
	  @fldFactorId int = NULL,
    @fldContractId int = NULL,
    @fldTankhahGroupId int=NULL,
    @fldDesc nvarchar(MAX),
	@fldUserId int,
		@fldOrganId int 

AS 

	BEGIN TRAN
	set @fldBabat=com.fn_TextNormalize(@fldBabat)
	set @fldBabatFlag=com.fn_TextNormalize(@fldBabatFlag)
	--declare @shoamrehesabid int
	--select @shoamrehesabid=fldIdShomareHesab from chk.tblDasteCheck where fldid=@fldIdDasteCheck
	UPDATE [chk].[tblCheck_Factor]
	SET    [fldFactorId] = @fldFactorId, [fldContractId] = @fldContractId, [fldTankhahGroupId] = @fldTankhahGroupId, [fldDate] = getdate(), [fldUserId] = @fldUserId
	WHERE    [fldCheckSadereId] = @fldId 
	if (@@ERROR<>0 )
	rollback
	else
	begin 
	 
		UPDATE [chk].[tblSodorCheck]
		SET    [fldIdDasteCheck] = @fldIdDasteCheck, [fldTarikhVosol] = @fldTarikhVosol, fldAshkhasId = @fldAshkhasId
		, [fldCodeSerialCheck] = @fldCodeSerialCheck, [fldBabat] = @fldBabat, [fldBabatFlag] = @fldBabatFlag, [fldMablagh] = @fldMablagh,
		 [fldDesc] = @fldDesc, [fldDate] = getdate(),fldUserId=@fldUserId,fldOrganId =	@fldOrganId 
		WHERE  [fldId] = @fldId
		if (@@ERROR<>0 )
			rollback
		else
		begin 
		if exists (select * from [chk].[tblCheck_Factor] where   [fldCheckSadereId] = @fldId and  [fldContractId] is null and  [fldTankhahGroupId] is null and 
			 [fldFactorId] is null)
			delete from [chk].[tblCheck_Factor]
			WHERE    [fldCheckSadereId] = @fldId 
			if (@@ERROR<>0 )
				rollback

		end 
	end 
	/*UPDATE [Drd].[tblCheck]
	SET    [fldId] = @fldId, [fldShomareHesabId] = @shoamrehesabid,[fldShomareSanad] = @fldCodeSerialCheck, [fldTarikhSarResid] = @fldTarikhVosol
	, [fldMablaghSanad] = @fldMablagh,[fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	, [fldBabat] = @fldBabat, [fldBabatFlag] = @fldBabatFlag,  [fldIdDasteCheck] = @fldIdDasteCheck
	,fldashkhasId=@fldAshkhasId,fldOrganId =	@fldOrganId 
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
	rollback*/
	COMMIT TRAN
GO
