SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalHokmUpdate] 
    @fldId int,
    @fldPrs_PersonalInfoId int,
    @fldTarikhEjra nvarchar(10),
    @fldTarikhSodoor nvarchar(10),
    @fldTarikhEtmam nvarchar(10),
    @fldAnvaeEstekhdamId int,

    @fldGroup tinyint,
    @fldMoreGroup tinyint,
    @fldShomarePostSazmani nvarchar(10),
    @fldTedadFarzand tinyint,
    @fldTedadAfradTahteTakafol tinyint,
    @fldTypehokm nvarchar(MAX),
    @fldShomareHokm nvarchar(100),
    @fldStatusHokm bit,
    @fldDescriptionHokm nvarchar(MAX),
    @fldCodeShoghl nvarchar(10),
    @fldStatusTaaholId INT,
    @fldFileId INT,
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(4),
    @fldUserId int,
 
    @fldDesc nvarchar(MAX),
	@fldMashmooleBime int,
	@fldTatbigh1 int,
	@fldTatbigh2 int,
	@fldHasZaribeTadil bit,
	@fldZaribeSal1 smallint,
	@fldZaribeSal2 SMALLINT,
	@fldTarikhShoroo NVARCHAR(10),
	@fldHokmType tinyint
AS 
	BEGIN TRAN
		SET @fldTypehokm=Com.fn_TextNormalize(@fldTypehokm)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldDescriptionHokm=Com.fn_TextNormalize(@fldDescriptionHokm)
	declare @IdHistory INT,@Isar NVARCHAR(200),@CodePosti NVARCHAR(10),@Address NVARCHAR(max),@MadrakTahsili NVARCHAR(100),@ReshteTahsili NVARCHAR(100)
	,@RasteShoghli NVARCHAR(200),@ReshteShoghli NVARCHAR(200),@OrganizationalPosts NVARCHAR(150),@Tabaghe NVARCHAR(100),@MojavezEstekhdam  NVARCHAR(200),@TarikhMojavez NVARCHAR(10),
	@MahleKhedmat NVARCHAR(500),@flag BIT=0,@fldMadrakid INT--,    @fldStatusTaaholId int
	SELECT   @Isar=tblVaziyatEsargari.fldTitle,@CodePosti=Com.tblEmployee_Detail.fldCodePosti,@Address=Com.tblEmployee_Detail.fldAddress
	,@MadrakTahsili=isnull(t.fldMadrakTahsiliTitle,tblMadrakTahsili.fldTitle)
	,@ReshteTahsili=isnull(t.fldReshteTahsiliTitle,Com.tblReshteTahsili.fldTitle),@RasteShoghli=fldRasteShoghli,@ReshteShoghli=fldReshteShoghli,@OrganizationalPosts=tblOrganizationalPosts.fldTitle
	,@Tabaghe=fldTabaghe,@MojavezEstekhdam=fldSh_MojavezEstekhdam,@TarikhMojavez=fldTarikhMajavezEstekhdam,@MahleKhedmat=Com.fn_stringDecode(tblOrgan.fldName)+'_'+tblChartOrgan.fldTitle
	,@fldMadrakid=isnull(t.fldMadrakId,tblEmployee_Detail.fldMadrakId)

--,    @fldStatusTaaholId =fldTaaholId
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrgan ON tblChartOrgan.fldOrganId = tblOrgan.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,m.fldTitle as fldMadrakTahsiliTitle,r.fldTitle as fldReshteTahsiliTitle 
									from com.tblHistoryTahsilat as t INNER JOIN
									 Com.tblMadrakTahsili as m ON t.fldMadrakId = m.fldId INNER JOIN
									 Com.tblReshteTahsili as r ON t.fldReshteId = r.fldId
						  where t.fldEmployeeId=tblEmployee.fldid and t.fldTarikh<=@fldTarikhEjra order by T.fldTarikh DESC)t
                      WHERE Prs_tblPersonalInfo.fldId=@fldPrs_PersonalInfoId
	IF(@fldFileId IS NULL AND @fldFile IS null) OR (@fldFileId IS NOT NULL AND @fldFile IS NULL)
	BEGIN
		UPDATE [Prs].[tblPersonalHokm]
		SET    [fldId] = @fldId, [fldPrs_PersonalInfoId] = @fldPrs_PersonalInfoId, [fldTarikhEjra] = @fldTarikhEjra, [fldTarikhSodoor] = @fldTarikhSodoor, [fldTarikhEtmam] = @fldTarikhEtmam, [fldAnvaeEstekhdamId] = @fldAnvaeEstekhdamId,  [fldGroup] = @fldGroup, [fldMoreGroup] = @fldMoreGroup, [fldShomarePostSazmani] = @fldShomarePostSazmani, [fldTedadFarzand] = @fldTedadFarzand, [fldTedadAfradTahteTakafol] = @fldTedadAfradTahteTakafol, [fldTypehokm] = @fldTypehokm, [fldShomareHokm] = @fldShomareHokm, [fldStatusHokm] = @fldStatusHokm, [fldDescriptionHokm] = @fldDescriptionHokm, [fldCodeShoghl] = @fldCodeShoghl, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldfileId=@fldFileId,fldStatusTaaholId=@fldStatusTaaholId,fldMashmooleBime=@fldMashmooleBime,fldTatbigh1=@fldTatbigh1,fldTatbigh2=@fldTatbigh2,fldHasZaribeTadil=@fldHasZaribeTadil,fldZaribeSal1=@fldZaribeSal1,fldZaribeSal2=@fldZaribeSal2,fldTarikhShoroo=@fldTarikhShoroo
		,fldHokmType=@fldHokmType
		WHERE  [fldId] = @fldId
		IF(@@ERROR<>0)
		BEGIN
		ROLLBACK
		SET @flag=1
		END
		IF(@flag=0)
		BEGIN
		DELETE FROM Prs.tblHokm_InfoPersonal_History 
		WHERE fldPersonalHokmId=@fldId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
		end
		IF(@flag=0)
		BEGIN
		select @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHokm_InfoPersonal_History] 
		INSERT INTO Prs.tblHokm_InfoPersonal_History( fldId ,fldPersonalHokmId ,fldStatusEsargari ,fldCodePosti ,fldAddress ,fldMadrakTahsili ,fldReshteTahsili ,fldRasteShoghli ,fldReshteShoghli ,fldOrganizationalPosts ,fldTabaghe , fldShomareMojavezEstekhdam ,fldTarikhMojavezEstekhdam , fldMahleKhedmat ,fldUserId ,fldDate ,fldDesc,fldMadrakid)
		SELECT @IdHistory,@fldId,@Isar,@CodePosti,@Address,@MadrakTahsili,@ReshteTahsili,@RasteShoghli,@ReshteShoghli,@OrganizationalPosts,@Tabaghe,@MojavezEstekhdam,@TarikhMojavez,@MahleKhedmat,@fldUserId,GETDATE(),@fldDesc,@fldMadrakid
			IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			SET @flag=1
			END
		END
	END
	else IF( @fldFile IS NOT  NULL AND @fldFileId IS NOT  NULL) 
	BEGIN
		UPDATE Com.tblFile
		SET fldImage=@fldFile,fldPasvand=@fldPasvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
		WHERE fldid=@fldFileId
		IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			SET @flag=1
			END
		IF(@flag=0)
		BEGIN	
			UPDATE [Prs].[tblPersonalHokm]
			SET    [fldId] = @fldId, [fldPrs_PersonalInfoId] = @fldPrs_PersonalInfoId, [fldTarikhEjra] = @fldTarikhEjra, [fldTarikhSodoor] = @fldTarikhSodoor, [fldTarikhEtmam] = @fldTarikhEtmam, [fldAnvaeEstekhdamId] = @fldAnvaeEstekhdamId,  [fldGroup] = @fldGroup, [fldMoreGroup] = @fldMoreGroup, [fldShomarePostSazmani] = @fldShomarePostSazmani, [fldTedadFarzand] = @fldTedadFarzand, [fldTedadAfradTahteTakafol] = @fldTedadAfradTahteTakafol, [fldTypehokm] = @fldTypehokm, [fldShomareHokm] = @fldShomareHokm, [fldStatusHokm] = @fldStatusHokm, [fldDescriptionHokm] = @fldDescriptionHokm, [fldCodeShoghl] = @fldCodeShoghl, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldfileId=@fldFileId,fldStatusTaaholId=@fldStatusTaaholId,fldMashmooleBime=@fldMashmooleBime,fldTatbigh1=@fldTatbigh1,fldTatbigh2=@fldTatbigh2,fldHasZaribeTadil=@fldHasZaribeTadil,fldZaribeSal1=@fldZaribeSal1,fldZaribeSal2=@fldZaribeSal2,fldTarikhShoroo=@fldTarikhShoroo
			,fldHokmType=@fldHokmType
			WHERE  [fldId] = @fldId
			IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			SET @flag=1
			END
		end
		IF(@flag=0)
		BEGIN
		DELETE FROM Prs.tblHokm_InfoPersonal_History 
		WHERE fldPersonalHokmId=@fldId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
		IF(@flag=0)
		BEGIN
		select @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHokm_InfoPersonal_History] 
		INSERT INTO Prs.tblHokm_InfoPersonal_History( fldId ,fldPersonalHokmId ,fldStatusEsargari ,fldCodePosti ,fldAddress ,fldMadrakTahsili ,fldReshteTahsili ,fldRasteShoghli ,fldReshteShoghli ,fldOrganizationalPosts ,fldTabaghe , fldShomareMojavezEstekhdam ,fldTarikhMojavezEstekhdam , fldMahleKhedmat ,fldUserId ,fldDate ,fldDesc,fldMadrakid)
		SELECT @IdHistory,@fldId,@Isar,@CodePosti,@Address,@MadrakTahsili,@ReshteTahsili,@RasteShoghli,@ReshteShoghli,@OrganizationalPosts,@Tabaghe,@MojavezEstekhdam,@TarikhMojavez,@MahleKhedmat,@fldUserId,GETDATE(),@fldDesc,@fldMadrakid
		END
			IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			SET @flag=1
			END
		END
	END
	
	COMMIT TRAN
GO
