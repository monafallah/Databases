SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalHokmInsert] 
	@fldId INT OUT,
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
    @fldStatusTaaholId	int	,
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
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
	declare @IdHistory INT,@Isar NVARCHAR(200)='',@CodePosti NVARCHAR(10)='',@Address NVARCHAR(max),@MadrakTahsili NVARCHAR(100)='',@ReshteTahsili NVARCHAR(100)=''
	,@RasteShoghli NVARCHAR(200)='',@ReshteShoghli NVARCHAR(200)='',@OrganizationalPosts NVARCHAR(150)='',@Tabaghe NVARCHAR(100)='',@MojavezEstekhdam  NVARCHAR(200)='',@TarikhMojavez NVARCHAR(10)='',
	@MahleKhedmat NVARCHAR(500)='',@flag BIT=0,@fldMadrakid int--,    @fldStatusTaaholId INT,
	,@fldPostEjraee NVARCHAR(150)=''
	,@fldfileId INT
	SELECT   @Isar=tblVaziyatEsargari.fldTitle,@CodePosti=isnull(tblEmployee_Detail.fldCodePosti,''),@Address=isnull(tblEmployee_Detail.fldAddress,'')
	,@MadrakTahsili=isnull(t.fldMadrakTahsiliTitle,tblMadrakTahsili.fldTitle)
	,@ReshteTahsili=isnull(t.fldReshteTahsiliTitle,Com.tblReshteTahsili.fldTitle),@RasteShoghli=fldRasteShoghli,@ReshteShoghli=fldReshteShoghli,@OrganizationalPosts=tblOrganizationalPosts.fldTitle
	,@Tabaghe=fldTabaghe,@MojavezEstekhdam=fldSh_MojavezEstekhdam,@TarikhMojavez=fldTarikhMajavezEstekhdam,@MahleKhedmat=Com.fn_stringDecode(tblOrgan.fldName)+'_'+tblChartOrgan.fldTitle
--,    @fldStatusTaaholId =fldTaaholId
,@fldPostEjraee=tblOrganizationalPostsEjraee.fldTitle
,@fldMadrakid=isnull(t.fldMadrakId,tblEmployee_Detail.fldMadrakId)
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrgan ON tblChartOrgan.fldOrganId = tblOrgan.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,m.fldTitle as fldMadrakTahsiliTitle,r.fldTitle as fldReshteTahsiliTitle 
									from com.tblHistoryTahsilat as t INNER JOIN
									 Com.tblMadrakTahsili as m ON t.fldMadrakId = m.fldId INNER JOIN
									 Com.tblReshteTahsili as r ON t.fldReshteId = r.fldId
						  where t.fldEmployeeId=tblEmployee.fldid and t.fldTarikh<=@fldTarikhEjra order by T.fldTarikh DESC)t
                      WHERE Prs_tblPersonalInfo.fldId=@fldPrs_PersonalInfoId
	IF(@fldfile IS NULL)
	BEGIN
		SELECT @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblPersonalHokm] 
		INSERT INTO [Prs].[tblPersonalHokm] ([fldId], [fldPrs_PersonalInfoId], [fldTarikhEjra], [fldTarikhSodoor], [fldTarikhEtmam], [fldAnvaeEstekhdamId],  [fldGroup], [fldMoreGroup], [fldShomarePostSazmani], [fldTedadFarzand], [fldTedadAfradTahteTakafol], [fldTypehokm], [fldShomareHokm], [fldStatusHokm], [fldDescriptionHokm], [fldCodeShoghl], [fldUserId], [fldDate], [fldDesc],[fldMashmooleBime],[fldTatbigh1],[fldTatbigh2],[fldHasZaribeTadil],[fldZaribeSal1],[fldZaribeSal2],fldFileId,fldStatusTaaholId	,fldTarikhShoroo,fldHokmType)
		SELECT @fldId, @fldPrs_PersonalInfoId, @fldTarikhEjra, @fldTarikhSodoor, @fldTarikhEtmam, @fldAnvaeEstekhdamId, @fldGroup, @fldMoreGroup, @fldShomarePostSazmani, @fldTedadFarzand, @fldTedadAfradTahteTakafol, @fldTypehokm, @fldShomareHokm, @fldStatusHokm, @fldDescriptionHokm, @fldCodeShoghl, @fldUserId, GETDATE(), @fldDesc,@fldMashmooleBime,@fldTatbigh1,@fldTatbigh2,@fldHasZaribeTadil,@fldZaribeSal1,@fldZaribeSal2,NULL,@fldStatusTaaholId,@fldTarikhShoroo,@fldHokmType
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
		
		IF (@@ERROR<>0)
			ROLLBACK
		END
	END
	else
	BEGIN
		select @fldfileId =ISNULL(max(fldId),0)+1 FROM  Com.tblFile
		INSERT INTO Com.tblFile( fldId ,fldImage , fldPasvand ,fldUserId ,fldDesc ,fldDate)
		SELECT @fldfileId,@fldFile,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
		IF(@flag=0)
		BEGIN
		SELECT @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblPersonalHokm] 
		INSERT INTO [Prs].[tblPersonalHokm] ([fldId], [fldPrs_PersonalInfoId], [fldTarikhEjra], [fldTarikhSodoor], [fldTarikhEtmam], [fldAnvaeEstekhdamId],  [fldGroup], [fldMoreGroup], [fldShomarePostSazmani], [fldTedadFarzand], [fldTedadAfradTahteTakafol], [fldTypehokm], [fldShomareHokm], [fldStatusHokm], [fldDescriptionHokm], [fldCodeShoghl], [fldUserId], [fldDate], [fldDesc],[fldMashmooleBime],[fldTatbigh1],[fldTatbigh2],[fldHasZaribeTadil],[fldZaribeSal1],[fldZaribeSal2],fldFileId,fldStatusTaaholId,fldHokmType)
		SELECT @fldId, @fldPrs_PersonalInfoId, @fldTarikhEjra, @fldTarikhSodoor, @fldTarikhEtmam, @fldAnvaeEstekhdamId, @fldGroup, @fldMoreGroup, @fldShomarePostSazmani, @fldTedadFarzand, @fldTedadAfradTahteTakafol, @fldTypehokm, @fldShomareHokm, @fldStatusHokm, @fldDescriptionHokm, @fldCodeShoghl, @fldUserId, GETDATE(), @fldDesc,@fldMashmooleBime,@fldTatbigh1,@fldTatbigh2,@fldHasZaribeTadil,@fldZaribeSal1,@fldZaribeSal2,@fldfileId,@fldStatusTaaholId,@fldHokmType
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
		
		IF (@@ERROR<>0)
			ROLLBACK
		END
	END
	COMMIT
GO
