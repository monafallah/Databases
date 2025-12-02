SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTanzimateDaramadInsert] 
   
    @fldAvarezId int,
    @fldMaliyatId int,
    @fldTakhirId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldMablaghGerdKardan int,
	@fldOrganId INT,
	@fldNerkh decimal(5, 2),
	@fldChapShenaseGhabz_Pardakht bit,
	@fldShorooshenaseGhabz tinyint,
	@fldShomareHesabIdPishfarz INT,
	@fldSumMaliyat_Avarez bit 
   
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@Id INT,@FileId INT,@flag BIT=0
	IF EXISTS(SELECT * FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@fldOrganId)
	BEGIN
		UPDATE [Drd].[tblTanzimateDaramad]
				SET    [fldAvarezId] = @fldAvarezId, [fldMaliyatId] = @fldMaliyatId, [fldTakhirId] = @fldTakhirId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldMablaghGerdKardan=@fldMablaghGerdKardan,fldOrganId=@fldOrganId,fldNerkh=@fldNerkh,fldChapShenaseGhabz_Pardakht=@fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz=@fldShorooshenaseGhabz,fldShomareHesabIdPishfarz=@fldShomareHesabIdPishfarz
				,fldSumMaliyat_Avarez=@fldSumMaliyat_Avarez
				WHERE  fldOrganId=@fldOrganId
	END
	ELSE 
	BEGIN
		select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblTanzimateDaramad] 
		INSERT INTO [Drd].[tblTanzimateDaramad] ([fldId], [fldAvarezId], [fldMaliyatId], [fldTakhirId], [fldUserId], [fldDesc], [fldDate],fldMablaghGerdKardan,fldOrganId,fldNerkh,fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz,fldShomareHesabIdPishfarz ,fldSumMaliyat_Avarez)
		SELECT @fldId, @fldAvarezId, @fldMaliyatId, @fldTakhirId, @fldUserId, @fldDesc, getdate(),@fldMablaghGerdKardan,@fldOrganId,@fldNerkh,@fldChapShenaseGhabz_Pardakht,@fldShorooshenaseGhabz,@fldShomareHesabIdPishfarz,@fldSumMaliyat_Avarez

	END
	--SELECT @fldDefaultReportFish=fldDefaultReportFish 	from [Drd].[tblTanzimateDaramad] 	where fldOrganId=@fldOrganId

	--if exists( select fldOrganId 	from [Drd].[tblTanzimateDaramad] 	where fldOrganId=@fldOrganId)
	--BEGIN
	--		IF (@fldDefaultReportFish IS NULL AND @fldDefaultReportFishFile IS NOT NULL)
	--		BEGIN
	--			select @fldDefaultReportFish =ISNULL(max(fldId),0)+1 from com.tblFile 
	--			INSERT INTO Com.tblFile ( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
	--			SELECT @fldDefaultReportFish,@fldDefaultReportFishFile,'.frx',@fldUserId,@fldDesc,GETDATE()
	--			IF(@@ERROR<>0)
	--			BEGIN
	--				ROLLBACK 
	--				SET @flag=1
	--			END
	--			IF(@flag=0)
	--			BEGIN
	--			UPDATE [Drd].[tblTanzimateDaramad]
	--			SET    [fldAvarezId] = @fldAvarezId, [fldMaliyatId] = @fldMaliyatId, [fldTakhirId] = @fldTakhirId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldMablaghGerdKardan=@fldMablaghGerdKardan,fldOrganId=@fldOrganId,fldNerkh=@fldNerkh,fldChapShenaseGhabz_Pardakht=@fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz=@fldShorooshenaseGhabz,fldShomareHesabIdPishfarz=@fldShomareHesabIdPishfarz
	--			,fldSumMaliyat_Avarez=@fldSumMaliyat_Avarez,fldDefaultReportFish=@fldDefaultReportFish
	--			WHERE  fldOrganId=@fldOrganId
	--			IF(@@ERROR<>0)
	--			BEGIN
	--				ROLLBACK 
	--				SET @flag=1
	--			END
	--			end
	--		END
	--	IF(@fldDefaultReportFish IS not NULL AND @fldDefaultReportFishFile IS NULL)
	--	BEGIN
	--		UPDATE [Drd].[tblTanzimateDaramad]
	--		SET    [fldAvarezId] = @fldAvarezId, [fldMaliyatId] = @fldMaliyatId, [fldTakhirId] = @fldTakhirId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldMablaghGerdKardan=@fldMablaghGerdKardan,fldOrganId=@fldOrganId,fldNerkh=@fldNerkh,fldChapShenaseGhabz_Pardakht=@fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz=@fldShorooshenaseGhabz,fldShomareHesabIdPishfarz=@fldShomareHesabIdPishfarz,fldSumMaliyat_Avarez=@fldSumMaliyat_Avarez
	--		WHERE  fldOrganId=@fldOrganId
	--	END
	--	else
	--	BEGIN
	--		UPDATE Com.tblFile 
	--		SET fldImage=@fldDefaultReportFishFile,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	--		WHERE fldId=@fldDefaultReportFish
	--		IF(@@ERROR<>0)
	--			BEGIN
	--				ROLLBACK 
	--				SET @flag=1
	--			END
	--		IF(@flag=0)
	--		BEGIN	
	--		UPDATE [Drd].[tblTanzimateDaramad]
	--		SET    [fldAvarezId] = @fldAvarezId, [fldMaliyatId] = @fldMaliyatId, [fldTakhirId] = @fldTakhirId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldMablaghGerdKardan=@fldMablaghGerdKardan,fldOrganId=@fldOrganId,fldNerkh=@fldNerkh,fldChapShenaseGhabz_Pardakht=@fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz=@fldShorooshenaseGhabz,fldShomareHesabIdPishfarz=@fldShomareHesabIdPishfarz,fldSumMaliyat_Avarez=@fldSumMaliyat_Avarez--,fldDefaultReportFish=@fldDefaultReportFish
	--		WHERE  fldOrganId=@fldOrganId
	--		if (@@ERROR<>0)
	--			ROLLBACK
	--		end
	--	END
	--end
	--else
	--BEGIN
	--	select @fldDefaultReportFish =ISNULL(max(fldId),0)+1 from com.tblFile 
	--	INSERT INTO Com.tblFile ( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
	--	SELECT @fldDefaultReportFish,@fldDefaultReportFishFile,'.frx',@fldUserId,@fldDesc,GETDATE()
	--	IF(@@ERROR<>0)
	--		BEGIN
	--			ROLLBACK 
	--			SET @flag=1
	--		END
	--	IF(@flag=0)
	--	BEGIN	
	--	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblTanzimateDaramad] 
	--	INSERT INTO [Drd].[tblTanzimateDaramad] ([fldId], [fldAvarezId], [fldMaliyatId], [fldTakhirId], [fldUserId], [fldDesc], [fldDate],fldMablaghGerdKardan,fldOrganId,fldNerkh,fldChapShenaseGhabz_Pardakht,fldShorooshenaseGhabz,fldShomareHesabIdPishfarz ,fldSumMaliyat_Avarez,fldDefaultReportFish)
	--	SELECT @fldId, @fldAvarezId, @fldMaliyatId, @fldTakhirId, @fldUserId, @fldDesc, getdate(),@fldMablaghGerdKardan,@fldOrganId,@fldNerkh,@fldChapShenaseGhabz_Pardakht,@fldShorooshenaseGhabz,@fldShomareHesabIdPishfarz,@fldSumMaliyat_Avarez,@fldDefaultReportFish
	--	if (@@ERROR<>0)
	--		ROLLBACK
	--	END
	--end
	COMMIT
	
GO
