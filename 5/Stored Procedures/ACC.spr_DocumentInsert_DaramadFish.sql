SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentInsert_DaramadFish]
	@fldFiscalYearId int,
	@FishId int,
	@fldOrganId int=1,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int,
	@fldModuleSaveId int,
	@fldModuleErsalId int

	as 
begin try
	begin tran
		declare @fldDocumentNum int, 
			@fldArchiveNum NVARCHAR(50),
			@fldShomareFaree int,
			@fldDescriptionDocu nvarchar(MAX),
			@fldTarikhDocument CHAR(10),--=[Com].[MiladiTOShamsi](getdate()),
			@fldAccept tinyint=0,
			@fldType tinyint=1,
			@ItemAvarez int=22,
			@ItemMaliyat int=21,
			--@ItemMojodiNazdeBank int=19,
			@ItemAsnadDaryaftani int=14

		
		--,@FishId varchar(MAX)='30404;30300;30267;30232;30370;30292',
		declare @t table (id int,SourceId int ,cod int identity)
		SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
declare @IdError int
		declare @fldID int , @fldDetailID int ,@fldCaseId int,@flag bit=0,@logId int,@IDHeader1 int=0,@fldyear smallint=0,@ShakhsId int
		,@CodeAvarez int,@CodeMaliyat int,@CodeMojodiNazdeBank int,@CodeAsnadDaryaftani int,@CodingHeader int

		select @fldyear=fldYear from acc.tblFiscalYear where fldid=@fldFiscalYearId

		select @CodingHeader=fldId from Acc.tblCoding_Header
		where fldYear=@fldyear and fldOrganId=@fldOrganId

		select @ShakhsId=fldAshakhasID/*,@fldTarikhDocument=s.fldTarikh*/ from drd.tblSodoorFish as s inner join 
		Drd.tblElamAvarez as e ON s.fldElamAvarezId = e.fldId 
		where s.fldId=@FishId

		select @fldTarikhDocument=fldTarikh from drd.tblPardakhtFish where fldFishId=@FishId

 
		 select @CodeAvarez=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemAvarez and c.fldHeaderCodId=@CodingHeader

		  select @CodeMaliyat=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemMaliyat and c.fldHeaderCodId=@CodingHeader

		  select @CodeAsnadDaryaftani=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemAsnadDaryaftani and c.fldHeaderCodId=@CodingHeader

		 -- select @CodeMojodiNazdeBank=c.fldId from acc.tblTemplateCoding as t
		 --inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 --where t.fldItemId=@ItemMojodiNazdeBank and c.fldHeaderCodId=@CodingHeader

		 set @fldDescriptionDocu=N'واریزی  شماره فیش '+cast(@FishId as varchar(10))+N'توسط '+ Com.fn_NameAshkhasHaghighi_Hoghoghi(@ShakhsId)

		declare @temp table (id int identity,FishId int,fldID int ,fldDaramadCode nvarchar(50),fldMablaghDaramad bigint,fldSharheCodeDaramad nvarchar(200),ShomareHesadId int,fldCodingId int,fldItemId int,fldPercent int)
		if exists(select * from drd.tblSodoorFish_Detail where fldFishId=@FishId)
		begin
		;with daramad as(
		SELECT distinct   s.fldFishId,f.fldJamKol,f.fldMablaghAvarezGerdShode
		,(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId) as fldId,
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad
		WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) )) fldDaramadCode
		,
		SUM(isnull(c.fldtakhfifMaliyatValue ,c.fldMaliyatValue))OVER(PARTITION BY c.fldElamAvarezId)   AS fldMablaghDaramad
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE f.fldTarikh  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'مالیات' as fldSharheCodeDaramad
		,sh.fldShomareHesadId,@CodeMaliyat as CodingId,@ItemMaliyat as fldItemId
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE f.fldTarikh  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC) as fldPercent
		FROM       
		drd.tblSodoorFish as f  inner join
		drd.tblSodoorFish_Detail as s on s.fldFishId=f.fldId inner join  
		Drd.tblCodhayeDaramadiElamAvarez as c on c.fldID=s.fldCodeElamAvarezId INNER JOIN
		Drd.tblElamAvarez as e ON c.fldElamAvarezId = e.fldId INNER JOIN
		Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId INNER JOIN
		Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		WHERE   f.fldId=@FishId and sh.fldOrganId=@fldOrganId
		AND cd.fldMashmooleArzesheAfzoode=1
 
		 union all 

		SELECT distinct s.fldFishId,f.fldJamKol,f.fldMablaghAvarezGerdShode,(SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId),
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad 
		WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) ))

		,SUM(isnull(c.fldtakhfifAvarezValue,c.fldAvarezValue )) OVER(PARTITION BY c.fldElamAvarezId)  AS fldAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE f.fldTarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'عوارض'
		,sh.fldShomareHesadId,@CodeAvarez as CodingId,@ItemAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE f.fldTarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)
		FROM         
		drd.tblSodoorFish as f  inner join
		drd.tblSodoorFish_Detail as s on s.fldFishId=f.fldId inner join  
		Drd.tblCodhayeDaramadiElamAvarez as c on c.fldID=s.fldCodeElamAvarezId INNER JOIN
		Drd.tblElamAvarez as e ON c.fldElamAvarezId =e.fldId INNER JOIN
		Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId =sh.fldId INNER JOIN
		Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		WHERE f.fldId=@FishId and sh.fldOrganId =@fldOrganId
		AND cd.fldMashmooleArzesheAfzoode=1



		union all
		SELECT     fldFishId,fldJamKol,fldMablaghAvarezGerdShode,codeelam ,  fldDaramadCode, 
						   fldMablaghDaramad
							, fldSharheCodeDaramad
						--,isnull([Drd].[Fn_MablaghTakhfif_Sodoor]('MablaghTakhfif',c.fldElamAvarezId,c.fldShomareHesabId,@fldOrganId
						--,sh.fldShorooshenaseGhabz) ,CAST(0 AS bigint)) Takhfif
						,fldShomareHesadId,fldId,0,0
			from
				(SELECT  distinct   s.fldFishId,f.fldJamKol,f.fldMablaghAvarezGerdShode,c.fldID codeelam ,  parent.fldDaramadCode, 
						   CAST(c.fldSumAsli AS BIGINT) AS fldMablaghDaramad
							 , parent.fldDaramadTitle AS fldSharheCodeDaramad
						--,isnull([Drd].[Fn_MablaghTakhfif_Sodoor]('MablaghTakhfif',c.fldElamAvarezId,c.fldShomareHesabId,@fldOrganId
						--,sh.fldShorooshenaseGhabz) ,CAST(0 AS bigint)) Takhfif
						,sh.fldShomareHesadId,d.fldId,max(parent.fldlevel) over (partition by c.fldid order by c.fldid)maxlevel
						,parent.fldlevel

		FROM 
		drd.tblSodoorFish as f  inner join
		drd.tblSodoorFish_Detail as s on s.fldFishId=f.fldId inner join
		Drd.tblCodhayeDaramadiElamAvarez as c on c.fldID=s.fldCodeElamAvarezId INNER JOIN
		Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId INNER JOIN
		Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId 
		inner JOIN drd.tblCodhayeDaramd parent
		ON cd.fldDaramadId.IsDescendantOf(parent.fldDaramadId) = 1
		inner join
		acc.tblCoding_Details as d on d.fldDaramadCode=parent.fldDaramadCode
		cross apply    (select top 1 fldTempNameId from     
						 acc.tblCoding_Details as p   
						inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
						where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
		WHERE --tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value )AND
		  f.fldId=@FishId and sh.fldOrganId =@fldOrganId and d.fldHeaderCodId=@CodingHeader
		--IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))
			)x
			where maxlevel=fldLevel
		) 
		insert @temp
		select fldFishId,fldId,fldDaramadCode,mablaghNahaee,fldSharheCodeDaramad,fldShomareHesadId,CodingId,fldItemId,fldPercent from(
		select *
		,case when rowId=MAX(rowId) over (partition by fldFishId) and mablaghEkhtelaf<>0 then fldMablaghDaramad-mablaghEkhtelaf else fldMablaghDaramad end mablaghNahaee
		from (
		select ROW_NUMBER() over (partition by fldFishId order by fldFishId) as rowId,fldJamKol-fldMablaghAvarezGerdShode as mablaghEkhtelaf,* from daramad
		)t
		)t2

		end
		else/*اگر فیش تقسیط شده باشه*/
		begin
		with daramad as(


		SELECT distinct   s.fldId as fldFishId,s.fldJamKol,s.fldMablaghAvarezGerdShode
		,(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId) as fldId,
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad
		WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) )) fldDaramadCode
		--,SUM(isnull(c.fldtakhfifMaliyatValue ,c.fldMaliyatValue))OVER(PARTITION BY c.fldElamAvarezId)   AS fldMablaghDaramad
		,cast((ceiling((CAST(SUM(isnull(c.fldtakhfifMaliyatValue ,c.fldMaliyatValue))OVER(PARTITION BY c.fldElamAvarezId) AS decimal(15,0))/(su.SumAsli)*fldJamKol))) AS BIGINT) AS fldMablaghDaramad
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikh  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'مالیات' as fldSharheCodeDaramad
		,sh.fldShomareHesadId,@CodeMaliyat  as CodingId,@ItemMaliyat as fldItemId
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikh  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC) as fldPercent
		from  
		 drd.tblSodoorFish as s 
		inner join drd.tblElamAvarez as e on e.fldId=s.fldElamAvarezId
		inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
		INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId 
		INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(fldtakhfifAvarezValue,fldAvarezValue ,0))
						+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0)) as SumAsli 
						from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
		 where  s.fldId=@FishId and  NOT exists (SELECT fldFishId FROM Drd.tblSodoorFish_Detail as d where d.fldFishId=s.fldId)
		AND cd.fldMashmooleArzesheAfzoode=1

		union all

		SELECT distinct s.fldId,s.fldJamKol,s.fldMablaghAvarezGerdShode,(SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId),
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad 
		WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) ))
		--,SUM(isnull(fldtakhfifAvarezValue,fldAvarezValue )) OVER(PARTITION BY c.fldElamAvarezId)  AS fldAvarez
		,cast((ceiling((CAST(sum(isnull(c.fldtakhfifAvarezValue,c.fldAvarezValue )) OVER(PARTITION BY c.fldElamAvarezId) AS decimal(15,0))/(su.SumAsli)*s.fldJamKol))) AS BIGINT) AS fldAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'عوارض'
		,sh.fldShomareHesadId,@CodeAvarez as CodingId,@ItemAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)
		from   
		 drd.tblSodoorFish as s 
		inner join drd.tblElamAvarez as e on e.fldId=s.fldElamAvarezId
		inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
		INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId =sh.fldId 
		INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(fldtakhfifAvarezValue,fldAvarezValue ,0))
						+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0)) as SumAsli 
						from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
		where   s.fldId=@FishId and NOT exists (SELECT fldFishId FROM Drd.tblSodoorFish_Detail as d where d.fldFishId=s.fldId)
		AND cd.fldMashmooleArzesheAfzoode=1

		union all

		select   FishId,fldJamKol,fldMablaghAvarezGerdShode,codeelam,fldDaramadCode
		--,cast((ceiling((CAST(c.fldSumAsli AS decimal(15,0))/sum(CAST(c.fldSumAsli AS BIGINT)) over (partition by e.fldId)*fldJamKol))) AS BIGINT)fldMablaghDaramad,
		,fldMablaghDaramad
		, fldSharheCodeDaramad,fldShomareHesadId,fldId,0,0
	 from (	
			select distinct  s.fldId FishId,s.fldJamKol,s.fldMablaghAvarezGerdShode,c.fldID codeelam,parent.fldDaramadCode
			--,cast((ceiling((CAST(c.fldSumAsli AS decimal(15,0))/sum(CAST(c.fldSumAsli AS BIGINT)) over (partition by e.fldId)*fldJamKol))) AS BIGINT)fldMablaghDaramad,
			,cast((ceiling((CAST(c.fldSumAsli AS decimal(15,0)) /(su.SumAsli)*s.fldJamKol))) AS BIGINT)fldMablaghDaramad
			,parent.fldDaramadTitle fldSharheCodeDaramad,sh.fldShomareHesadId,d.fldId,max(parent.fldlevel) over (partition by c.fldid order by c.fldid)maxlevel
							,parent.fldlevel
			from  
			drd.tblSodoorFish as s 
			inner join drd.tblElamAvarez as e on e.fldId=s.fldElamAvarezId
			inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
			INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId 
			INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId 	
			inner JOIN drd.tblCodhayeDaramd parent  ON cd.fldDaramadId.IsDescendantOf(parent.fldDaramadId) = 1
			inner join
			acc.tblCoding_Details as d on d.fldDaramadCode=parent.fldDaramadCode
		
			cross apply    (select top 1 fldTempNameId from     
							 acc.tblCoding_Details as p   
							inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
							where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
			cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(fldtakhfifAvarezValue,fldAvarezValue ,0))
							+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0))as SumAsli 
							from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
			where  s.fldId=@FishId and NOT exists (SELECT fldFishId FROM Drd.tblSodoorFish_Detail as d where d.fldFishId=s.fldId)
			and d.fldHeaderCodId=@CodingHeader
			)x 
				where maxlevel=fldLevel

		) 
		insert @temp
		select fldFishId,fldId,fldDaramadCode,mablaghNahaee,fldSharheCodeDaramad,fldShomareHesadId,CodingId,fldItemId,fldPercent from(
		select * 
		,case when rowId=MAX(rowId) over (partition by fldFishId) and mablaghEkhtelaf<>0 then fldMablaghDaramad-mablaghEkhtelaf else fldMablaghDaramad end as mablaghNahaee
		from (
		select ROW_NUMBER() over (partition by fldFishId order by fldFishId) as rowId
		,sum(fldMablaghDaramad) over (partition by fldFishId)-fldMablaghAvarezGerdShode as mablaghEkhtelaf,* 
		from daramad
		)t
		)t2

		end

		--if(@fldModuleSaveId<>4)
		--	begin
					select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
					 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					and h1.fldModuleSaveId=@fldModuleSaveId
			--end
	
			--else if(@fldTypeSanad=1)
			--	set @fldDocumentNum=1
			--else
			--begin
			--	select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
			--	 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
			--inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			--	where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
			--	and h1.fldModuleSaveId=@fldModuleSaveId

			--	if(@fldDocumentNum=1)
			--		set @fldDocumentNum=2
			--end
			select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
			INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
			SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldType,@fldFiscalYearId

			select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
			INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
			SELECT @IDHeader1,@fldID, @fldDocumentNum, @fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,2,null,2

		--select 300.0/800*400,500.0/800*400
		/*اینزرت کدهای درآمد بستانکار*/
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
		if(@CodeAvarez is not null)/*اگر کدینگ عوارض اون سال مالی ثبت نشده بود جمع مالیات و عوارض در کیدنیگ مالیات اینزرت میکنیم*/
		begin
			INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
			SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId,@IDHeader1, fldCodingId, t.fldSharheCodeDaramad, 0, t.fldMablaghDaramad, null, null, @fldDesc, GETDATE(), @fldIP, @fldUserId,t.id 
			from @temp as t 
		end	
		else
		begin
			if exists (select * from @temp as t where fldItemId in (21,22) )
			begin
			INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
			select  row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,CodeMaliyat,fldSharheCodeDaramad,fldBedehkar,fldMablaghDaramad,fldCenterCoId,fldCaseId,fldDesc,fldDate,fldIP,fldUserId,fldOrder from(
			SELECT  @fldId as Document_HedearId,@IDHeader1 as Document_HedearId1 , @CodeMaliyat CodeMaliyat,cast( sum(fldPercent) as varchar(10))+N'%'+N'مالیات و عوارض' as fldSharheCodeDaramad, 0 fldBedehkar, sum(t.fldMablaghDaramad) fldMablaghDaramad, null as fldCenterCoId, null as fldCaseId, @fldDesc as fldDesc, GETDATE() as fldDate, @fldIP as fldIP, @fldUserId as fldUserId,1  as fldOrder
			from @temp as t where fldItemId in (21,22) )t
			end
			--union
			select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
			INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
			select  row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,CodeMaliyat,fldSharheCodeDaramad,fldBedehkar,fldMablaghDaramad,fldCenterCoId,fldCaseId,fldDesc,fldDate,fldIP,fldUserId,fldOrder from(
			SELECT  @fldId Document_HedearId,@IDHeader1 Document_HedearId1, fldCodingId CodeMaliyat, t.fldSharheCodeDaramad, 0 fldBedehkar, t.fldMablaghDaramad, null fldCenterCoId, null fldCaseId, @fldDesc fldDesc, GETDATE() fldDate, @fldIP fldIP, @fldUserId fldUserId,t.id fldOrder
			from @temp as t where fldItemId =0
			)t
		end
		/*اینزرت جمع کل مبلغ کدهای درامد با کدینگ اسناد دریافتنی بصورت بدهکار بستانکار با سورس فیش ایدی و کیس تایپ 6*/
		/*بدهکار*/
		select @fldCaseId=fldId from [ACC].[tblCase] where fldCaseTypeId=6 and fldSourceId=@FishId
		if(@fldCaseId is null or @fldCaseId=0)
		begin
			select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
						INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
						SELECT @fldCaseId, 6, @FishId, '', GETDATE(), @fldIP, @fldUserId 
					
		end
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @CodeAsnadDaryaftani, @fldDescriptionDocu,sum( t.fldMablaghDaramad), 0, null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						from @temp as t 


		update drd.tblPardakhtFish
		set fldDocumentHeaderId1=@IDHeader1
		where fldFishId=@FishId


		update [ACC].[tblDocumentRecord_Details] 
		 set fldOrder=1
		 where fldDocument_HedearId1=@IDHeader1 and fldBedehkar<>0

		 update s 
		 set fldOrder=orderid
		  from  [ACC].[tblDocumentRecord_Details] S 
		  cross apply (select ROW_NUMBER()over (order by r.fldid)+1 orderid , r.fldid from acc.tblDocumentRecord_Details r

								where fldDocument_HedearId1=@IDHeader1 and fldBestankar<>0) p
		 where fldDocument_HedearId1=@IDHeader1 and fldBestankar<>0 and p.fldId=s.fldid

		/*بستانکار*/
				/*	INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
					SELECT @fldCaseId+1, 6, @FishId, '', GETDATE(), @fldIP, @fldUserId 
					from  @temp as t 

		INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID+1, @fldId,@IDHeader1, @CodeAsnadDaryaftani, @fldDescriptionDocu, 0,sum( t.fldMablaghDaramad), null, @fldCaseId+1, @fldDesc, GETDATE(), @fldIP, @fldUserId,1 
						from @temp as t 
		/*******************************************************************/
		/*اینزرت جمع کل مبلغ کدهای درامد با کدینگ موجودی نزد بانک بدهکار با سورس شماره حساب فیش و کیس تایپ 5*/
		select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
					INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
					output inserted.fldid,inserted.fldSourceId into @t
					SELECT row_number() over (order by (select 1))+@fldCaseId, 5, t.ShomareHesadId, '', GETDATE(), @fldIP, @fldUserId 
					from  @temp as t 
					group by ShomareHesadId

		select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId,@IDHeader1, @CodeMojodiNazdeBank, @fldDescriptionDocu,sum( t.fldMablaghDaramad), 0, null, tt.id, @fldDesc, GETDATE(), @fldIP, @fldUserId
						,row_number() over (order by (select 1))
						from @temp as t 
						inner join @t as tt on tt.SourceId=t.ShomareHesadId
						group by tt.SourceId,t.ShomareHesadId,tt.id*/

		/*******************************************************************/
		select '' as ErrorCode,'' as ErrorMessage
	commit tran
end try
begin catch
rollback

select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'spr_DocumentInsert_DaramadFish',getdate() from com.tblUser where fldid=@fldUserId
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
end catch
GO
