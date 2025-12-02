SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentInsert_DaramadCheck]
	@fldFiscalYearId int,
	@fldCheckId int,
	@fldOrganId int=1,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int,
	@fldModuleSaveId int,
	@fldModuleErsalId int,
	@tarikh varchar(10)
	as 
begin try
	begin tran
		declare @fldDocumentNum int, 
			@fldArchiveNum NVARCHAR(50),
			@fldShomareFaree int,
			@fldDescriptionDocu nvarchar(MAX),
			@fldDescriptionDocuNew  nvarchar(MAX),
			@fldTarikhDocument CHAR(10),--=[Com].[MiladiTOShamsi](getdate()),
			@fldAccept tinyint=0,
			@fldType tinyint=1,
			@ItemAvarez int=22,
			@ItemMaliyat int=21,
			@ItemBesKol int=29,
			@ItemBedKol int=25,
			--@ItemMojodiNazdeBank int=19,
			@ItemAsnadDaryaftani int=38

		
		--,@FishId varchar(MAX)='30404;30300;30267;30232;30370;30292',
		declare @t table (id int,SourceId int ,cod int identity)
		SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
		declare @IdError int
		declare @fldID int , @fldDetailID int ,@fldCaseId int,@flag bit=0,@logId int,@IDHeader1 int=0,@fldyear smallint=0,@ShakhsId int
		,@CodeAvarez int,@CodeMaliyat int,@CodeMojodiNazdeBank int,@CodeAsnadDaryaftani int,@CodingHeader int,@maxorder int
		,@fldElamAvarezId int,@CodeBebKol int,@CodeBesKol int

		select @fldyear=fldYear from acc.tblFiscalYear where fldid=@fldFiscalYearId
		select @CodingHeader=fldId from Acc.tblCoding_Header
		where fldYear=@fldyear and fldOrganId=@fldOrganId

		select @fldElamAvarezId=r.fldElamAvarezId/*,@fldTarikhDocument=c.fldTarikhAkhz,*/,@ShakhsId= c.fldAshkhasId from  Drd.tblCheck as c
		inner join Drd.tblReplyTaghsit as r on r.fldId=c.fldReplyTaghsitId
		where c.fldId=@fldCheckId

		/*select @ShakhsId=fldAshakhasID/*,@fldTarikhDocument=s.fldTarikh*/ from drd.tblElamAvarez as s
		where s.fldId=@fldElamAvarezId*/
		set @fldTarikhDocument=@tarikh
 
		 select @CodeAvarez=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemAvarez and c.fldHeaderCodId=@CodingHeader

		  select @CodeMaliyat=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemMaliyat and c.fldHeaderCodId=@CodingHeader

		  select @CodeAsnadDaryaftani=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemAsnadDaryaftani and c.fldHeaderCodId=@CodingHeader

		 select @CodeBebKol=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemBedKol and c.fldHeaderCodId=@CodingHeader

		 
		 select @CodeBesKol=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemBesKol and c.fldHeaderCodId=@CodingHeader

		 -- select @CodeMojodiNazdeBank=c.fldId from acc.tblTemplateCoding as t
		 --inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 --where t.fldItemId=@ItemMojodiNazdeBank and c.fldHeaderCodId=@CodingHeader

		 set @fldDescriptionDocu=N'دریافت چک '+N'از '+ Com.fn_NameAshkhasHaghighi_Hoghoghi(@ShakhsId)+N' بابت اعلام عوارض شماره '+cast(@fldElamAvarezId as varchar(50))
		 
		 set @fldDescriptionDocuNew=N'دریافت چک '+N'از '+ Com.fn_NameAshkhasHaghighi_Hoghoghi(@ShakhsId)+N' بابت اعلام عوارض شماره '+cast(@fldElamAvarezId as varchar(50))

		declare @temp table (id int identity,CheckId int,fldID int ,fldDaramadCode nvarchar(50),fldMablaghDaramad bigint,fldSharheCodeDaramad nvarchar(200),ShomareHesadId int,fldCodingId int,fldItemId int,fldPercent int)
		
		begin
		with daramad as(

		SELECT distinct   s.fldId as fldCheckId,s.fldMablaghSanad as fldJamKol,s.fldMablaghSanad
		,(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId) as fldId,
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad
		WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) )) fldDaramadCode
		--,SUM(isnull(c.fldtakhfifMaliyatValue ,c.fldMaliyatValue))OVER(PARTITION BY c.fldElamAvarezId)   AS fldMablaghDaramad
		,cast((ceiling((CAST(SUM(isnull(c.fldtakhfifMaliyatValue ,c.fldMaliyatValue))OVER(PARTITION BY c.fldElamAvarezId) AS decimal(15,0))
		/(su.SumAsli)*s.fldMablaghSanad))) AS BIGINT) AS fldMablaghDaramad
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikhAkhz  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'مالیات' as fldSharheCodeDaramad
		,sh.fldShomareHesadId,@CodeMaliyat  as CodingId,@ItemMaliyat as fldItemId
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikhAkhz  BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC) as fldPercent
		from  
		 drd.tblCheck as s
		inner join drd.tblReplyTaghsit as t on t.fldId=s.fldReplyTaghsitId
		inner join drd.tblElamAvarez as e on e.fldId=t.fldElamAvarezId
		inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
		INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId 
		INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(ce.fldtakhfifAvarezValue,fldAvarezValue ,0))
						+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0)) as SumAsli 
						from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
		 where  s.fldId=@fldCheckId 
		AND cd.fldMashmooleArzesheAfzoode=1

		union all

		SELECT distinct s.fldId,s.fldMablaghSanad as fldJamKol,s.fldMablaghSanad,(SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId),
		(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad 
		WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=e.fldOrganId ) ))
		--,SUM(isnull(fldtakhfifAvarezValue,fldAvarezValue )) OVER(PARTITION BY c.fldElamAvarezId)  AS fldAvarez
		,cast((ceiling((CAST(sum(isnull(c.fldtakhfifAvarezValue,c.fldAvarezValue )) OVER(PARTITION BY c.fldElamAvarezId) AS decimal(15,0))
		/(su.SumAsli)*s.fldMablaghSanad))) AS BIGINT) AS fldAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikhAkhz BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'عوارض'
		,sh.fldShomareHesadId,@CodeAvarez as CodingId,@ItemAvarez
		,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeAvarez)-3) 
		FROM Com.tblMaliyatArzesheAfzoode WHERE s.fldTarikhAkhz BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)
		from   
		 drd.tblCheck as s
		inner join drd.tblReplyTaghsit as t on t.fldId=s.fldReplyTaghsitId
		inner join drd.tblElamAvarez as e on e.fldId=t.fldElamAvarezId
		inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
		INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId =sh.fldId 
		INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId
		cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(fldtakhfifAvarezValue,fldAvarezValue ,0))
						+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0)) as SumAsli 
						from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
		where   s.fldId=@fldCheckId 
		AND cd.fldMashmooleArzesheAfzoode=1

		union all

		select distinct  s.fldId,s.fldMablaghSanad as fldJamKol,s.fldMablaghSanad,c.fldID,cd.fldDaramadCode
		--,cast((ceiling((CAST(c.fldSumAsli AS decimal(15,0))/sum(CAST(c.fldSumAsli AS BIGINT)) over (partition by e.fldId)*fldJamKol))) AS BIGINT)fldMablaghDaramad,
		,cast((ceiling((CAST(c.fldSumAsli AS decimal(15,0)) /(su.SumAsli)*s.fldMablaghSanad))) AS BIGINT)fldMablaghDaramad
		,c.fldSharheCodeDaramad,sh.fldShomareHesadId,d.fldId,0,0
		from  
		drd.tblCheck as s
		inner join drd.tblReplyTaghsit as t on t.fldId=s.fldReplyTaghsitId
		inner join drd.tblElamAvarez as e on e.fldId=t.fldElamAvarezId
		inner join drd.tblCodhayeDaramadiElamAvarez as c on c.fldElamAvarezId=e.fldId
		INNER JOIN Drd.tblShomareHesabCodeDaramad as sh ON c.fldShomareHesabCodeDaramadId = sh.fldId 
		INNER JOIN Drd.tblCodhayeDaramd as cd ON sh.fldCodeDaramadId = cd.fldId inner join
		acc.tblCoding_Details as d on d.fldDaramadCode=cd.fldDaramadCode
		cross apply    (select top 1 fldTempNameId from     
						 acc.tblCoding_Details as p   
						inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
						where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
		cross apply(select sum(CAST(ce.fldSumAsli AS BIGINT))+sum(coalesce(fldtakhfifAvarezValue,fldAvarezValue ,0))
						+sum(coalesce(ce.fldtakhfifMaliyatValue ,ce.fldMaliyatValue,0))as SumAsli 
						from drd.tblCodhayeDaramadiElamAvarez as ce where ce.fldElamAvarezId=e.fldId)su
		where  s.fldId=@fldCheckId 
		and d.fldHeaderCodId=@CodingHeader
		) 
		insert @temp
		select fldCheckId,fldId,fldDaramadCode,mablaghNahaee,fldSharheCodeDaramad,fldShomareHesadId,CodingId,fldItemId,fldPercent from(
		select * 
		,case when rowId=MAX(rowId) over (partition by fldCheckId) and mablaghEkhtelaf<>0 then fldMablaghDaramad-mablaghEkhtelaf else fldMablaghDaramad end as mablaghNahaee
		from (
		select ROW_NUMBER() over (partition by fldCheckId order by fldCheckId) as rowId
		,sum(fldMablaghDaramad) over (partition by fldCheckId)-fldMablaghSanad as mablaghEkhtelaf,* 
		from daramad
		)t
		)t2

		end

		
					select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
					 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					and h1.fldModuleSaveId=@fldModuleSaveId
		
			select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
			INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
			SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldType,@fldFiscalYearId

			select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
			INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
			SELECT @IDHeader1,@fldID, @fldDocumentNum, @fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,2,null,2

		
		/*اینزرت کدهای درآمد بستانکار*/
		
		if(@CodeAvarez is not null)/*اگر کدینگ عوارض اون سال مالی ثبت نشده بود جمع مالیات و عوارض در کیدنیگ مالیات اینزرت میکنیم*/
		begin
			select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
			INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
			SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId,@IDHeader1, fldCodingId, t.fldSharheCodeDaramad, 0, t.fldMablaghDaramad, null, null, @fldDesc, GETDATE(), @fldIP, @fldUserId,t.id 
			from @temp as t 
		end	
		else
		begin
			if exists (select * from @temp where fldItemId in (21,22) )
			begin 
				select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				select  row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,CodeMaliyat,fldSharheCodeDaramad,fldBedehkar,fldMablaghDaramad,fldCenterCoId,fldCaseId,fldDesc,fldDate,fldIP,fldUserId,fldOrder from(
				SELECT  @fldId as Document_HedearId,@IDHeader1 as Document_HedearId1 , @CodeMaliyat CodeMaliyat,cast( sum(fldPercent) as varchar(10))+N'%'+N'مالیات و عوارض' as fldSharheCodeDaramad, 0 fldBedehkar, sum(t.fldMablaghDaramad) fldMablaghDaramad, null as fldCenterCoId, null as fldCaseId, @fldDesc as fldDesc, GETDATE() as fldDate, @fldIP as fldIP, @fldUserId as fldUserId,1  as fldOrder
				from @temp as t where fldItemId in (21,22) )t1
			end 
			if exists (select * from @temp where fldItemId =0 )
			begin
				select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details]  
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				select  row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,fldCodingId,fldSharheCodeDaramad,fldBedehkar,fldMablaghDaramad,fldCenterCoId,fldCaseId,fldDesc,fldDate,fldIP,fldUserId,fldOrder from(
				SELECT  @fldId as Document_HedearId,@IDHeader1 as Document_HedearId1  , fldCodingId, t.fldSharheCodeDaramad, 0 fldBedehkar, t.fldMablaghDaramad, null as fldCenterCoId, null as fldCaseId, @fldDesc as fldDesc, GETDATE() as fldDate, @fldIP as fldIP, @fldUserId as fldUserId,t.id  fldOrder
				from @temp as t where fldItemId =0
				)t
			end		
		end
		/*اینزرت جمع کل مبلغ کدهای درامد با کدینگ اسناد دریافتنی بصورت بدهکار بستانکار با سورس چک ایدی و کیس تایپ 3*/
		/*بدهکار*/
		select @fldCaseId=fldId from [ACC].[tblCase] where fldCaseTypeId=3 and fldSourceId=@fldCheckId
		if(@fldCaseId is null or @fldCaseId=0)
		begin
			select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
						INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
						SELECT @fldCaseId, 3, @fldCheckId, '', GETDATE(), @fldIP, @fldUserId 
					
		end
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @CodeAsnadDaryaftani, @fldDescriptionDocu,sum( t.fldMablaghDaramad), 0, null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						from @temp as t 
----------------------------------بدهکار با ایتم ایدی25
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @CodeBebKol, @fldDescriptionDocuNew,sum( t.fldMablaghDaramad), 0, null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						from @temp as t 
----------------------------------بستانکار با ایتم ایدی 29
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @CodeBesKol, @fldDescriptionDocuNew,0,sum( t.fldMablaghDaramad), null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						from @temp as t 

	 
	 update [ACC].[tblDocumentRecord_Details] 
		 set fldOrder=1
		 where fldDocument_HedearId1=@IDHeader1 and fldBedehkar<>0 and fldCodingId=@CodeAsnadDaryaftani

		 update s 
		 set fldOrder=orderid
		  from  [ACC].[tblDocumentRecord_Details] S 
		  cross apply (select ROW_NUMBER()over (order by r.fldid)+1 orderid , r.fldid from acc.tblDocumentRecord_Details r

								where fldDocument_HedearId1=@IDHeader1 and fldBestankar<>0) p
		 where fldDocument_HedearId1=@IDHeader1 and fldBestankar<>0 and p.fldId=s.fldid

		 select @maxorder =max(fldOrder)+1 from [ACC].[tblDocumentRecord_Details] where fldDocument_HedearId1=@IDHeader1 
		 update [ACC].[tblDocumentRecord_Details] 
		 set fldOrder=@maxorder
		 where fldDocument_HedearId1=@IDHeader1 /*and fldBedehkar<>0*/ and fldCodingId=@CodeBebKol
		 
		select @maxorder =max(fldOrder)+1 from [ACC].[tblDocumentRecord_Details] where fldDocument_HedearId1=@IDHeader1 
		 update [ACC].[tblDocumentRecord_Details] 
		 set fldOrder=@maxorder
		 where fldDocument_HedearId1=@IDHeader1 /*and fldBedehkar<>0*/ and fldCodingId=@CodeBesKol

		select 0 as ErrorCode,'' as ErrorMessage,@IDHeader1 fldId
	commit tran
end try
begin catch
rollback

select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'spr_DocumentInsert_DaramadCheck',getdate() from com.tblUser where fldid=@fldUserId
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage,0 as fldId
end catch
GO
