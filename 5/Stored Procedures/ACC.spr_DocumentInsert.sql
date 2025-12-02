SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentInsert]
	@fldDocumentNum int out,  
    @fldArchiveNum NVARCHAR(50),
    @fldDescriptionDocu nvarchar(MAX),
    @fldOrganId int,
    @fldTarikhDocument CHAR(10),
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int,
	@fldAccept tinyint,
	@fldType tinyint,
	@fldModuleSaveId int,
	@fldModuleErsalId int,
	@fldShomareFaree int,
	@fldFiscalYearId int,
	@fldTypeSanad int,
	@fldPid int,
	@fldEdit tinyint,
	@Detail Acc.DocumentDetail readOnly
	
	/*@fldCodingId int,
    @fldDescription nvarchar(MAX),
    @fldBedehkar bigint,
    @fldBestankar bigint,
    @fldCenterCoId int,
    @fldCaseTypeId int,
	@fldSourceId int,*/

	/*@fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int*/

	as
	begin tran
	declare @t table (id int ,CaseTypeId int, SourceId int)
	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int , @fldDetailID int ,@fldCaseId int,@flag bit=0,@logId int,@IDHeader1 int=0,@fldyear smallint=0
	select @fldyear=fldYear from acc.tblFiscalYear where fldId=@fldFiscalYearId

	--if @fldDocumentNum<>0 and  exists (select * from [ACC].[tblDocumentRecord_Header]  where fldOrganId=@fldOrganId and fldModuleSaveId=@fldModuleSaveId and fldFiscalYearId=@fldFiscalYearId and fldDocumentNum=@fldDocumentNum)
	if(@fldType=2)
		set @fldDocumentNum=0
	else if(@fldModuleSaveId<>4)
	begin
			select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
			 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
			and h1.fldModuleSaveId=@fldModuleSaveId
	end
	
	else if(@fldTypeSanad=1)
		set @fldDocumentNum=1
	else
	begin
		select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
		 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
		where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
		and h1.fldModuleSaveId=@fldModuleSaveId

		if(@fldDocumentNum=1)
			set @fldDocumentNum=2
	end

	
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
	INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
	--output inserted.fldId
	SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldType,@fldFiscalYearId
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
	select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
	INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
	--output inserted.fldId
	SELECT @IDHeader1,@fldID, @fldDocumentNum, @fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,@fldTypeSanad,@fldPid,@fldEdit
	if (@@ERROR<>0)
		ROLLBACK
	else
	Begin

			select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
			INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
			--output inserted.fldid,inserted.fldCaseTypeId,inserted.fldSourceId into @t
			SELECT row_number()over (order by (select 1  ))+@fldCaseId, d.fldCaseTypeId, d.fldSourceId, '', GETDATE(), @fldIP, @fldUserId from @detail as d
			left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
			where d.fldSourceId<>0 and c.fldId is null
			group by d.fldCaseTypeId, d.fldSourceId
			if (@@ERROR<>0)
			begin
				ROLLBACK
				set @flag=1
			end
		if (@flag=0)
			begin
			select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, c.fldId, @fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder from 
				@detail as d
				left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
				--cross apply (select * from @t as t where t.CaseTypeId=t1.fldCaseTypeId and t.SourceId=t1.fldSourceId)t
				--SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, id, @fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder from 
				--@t t
				--cross apply (select row_number() over (order by (select 1))c,* from @detail where fldSourceId<>0)t1
				--where t1.c=t.cod
				if (@@ERROR<>0)
					ROLLBACK
			end
		if (@flag=0)
			begin
				/*select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, NULL, @fldDesc, GETDATE(), @fldIP, @fldUserId ,fldorder from 
				 @detail where fldSourceId=0
				if (@@ERROR<>0)
					ROLLBACK
				else*/
					if (@fldTypeSanad=4)
						begin
							update h1 
							set fldAccept=1
							from [ACC].[tblDocumentRecord_Header1]  h1
							--inner join [ACC].[tblDocumentRecord_Header]  h on h.fldId=h1.fldDocument_HedearId
							--where h.fldOrganId =@fldOrganId and h1.fldModuleSaveId=@fldModuleSaveId and h.fldFiscalYearId=@fldFiscalYearId 
							--and h.fldtype=1 and h1.fldAccept=0
							where h1.fldid=@IDHeader1
							if (@@ERROR<>0)
								rollback
							else
							begin
								select @logId =ISNULL(max(fldId),0) from [ACC].tblDocument_HeaderLog 
								insert into Acc.tblDocument_HeaderLog(fldid,fldHeaderId,fldUserId,fldDate)
								select row_number()over (order by h1.fldid)+@logId,h1.fldid,@fldUserId,getdate() 
								from 
								--acc.tblDocumentRecord_Header h
								--inner join
								[ACC].[tblDocumentRecord_Header1]  h1 --on h.fldId=h1.fldDocument_HedearId
								where h1.fldid=@IDHeader1
								--h.fldOrganId =@fldOrganId and fldModuleSaveId=@fldModuleSaveId and fldFiscalYearId=@fldFiscalYearId
								--and fldtype=1 and fldAccept=1
									and not exists(select * from acc.tblDocument_HeaderLog where fldHeaderId=h1.fldid)
								if (@@ERROR<>0)
									rollback

							end

						end
						else if (@fldTypeSanad=5)
						begin
							update h1 
							set fldAccept=1
							from [ACC].[tblDocumentRecord_Header1]  h1
							inner join [ACC].[tblDocumentRecord_Header]  h on h.fldId=h1.fldDocument_HedearId
							where h.fldOrganId =@fldOrganId and h1.fldModuleSaveId=4 and h.fldFiscalYearId=@fldFiscalYearId 
							and h.fldtype=1 and h1.fldAccept=0
							if (@@ERROR<>0)
								rollback
								else
											begin
												select @logId =ISNULL(max(fldId),0) from [ACC].tblDocument_HeaderLog 
												insert into Acc.tblDocument_HeaderLog(fldid,fldHeaderId,fldUserId,fldDate)
												select row_number()over (order by h.fldid)+@logId,h1.fldid,@fldUserId,getdate() 
												from acc.tblDocumentRecord_Header h
												inner join [ACC].[tblDocumentRecord_Header1]  h1 on h.fldId=h1.fldDocument_HedearId
												where  h.fldOrganId =@fldOrganId and fldModuleSaveId=@fldModuleSaveId and fldFiscalYearId=@fldFiscalYearId and fldtype=1 and fldAccept=1
													and not exists(select * from acc.tblDocument_HeaderLog where fldHeaderId=h1.fldid)
												if (@@ERROR<>0)
													rollback
												begin
														if(@fldModuleSaveId=4)
														begin
															--declare @fldOrganId int=1,@Year smallint=1401,@ModuleId int=4
															update tblDocumentRecord_Header1
															set fldDocumentNum=case when fldTypeSanadId=1 then 1 else  t.Shomare end ,fldUserId=@fldUserId
															from  acc.tblDocumentRecord_Header1 
															cross apply
																		(select 1+row_Number()over(order by h1.fldtypesanadId, h1.fldTarikhDocument,h1.fldDate)Shomare
																		,h1.fldid --,fldTypeSanadId
																		from acc.tblDocumentRecord_Header as h
																		inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
																		inner join acc.tblFiscalYear f on f.fldid =fldFiscalYearId
																		where h.fldorganId=@fldOrganId and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldModuleSaveId
																		and h1.fldDocumentNum<>0 and h1.fldTypeSanadId<>1/*سند افتتاحیه همیشه شماره سندش 1 میباشد*/
																		)t
															where tblDocumentRecord_Header1.fldid=t.fldid
																if (@@error<>0)
																rollback
														end
													else
														begin
															update tblDocumentRecord_Header1
															set fldDocumentNum=t.Shomare ,fldUserId=@fldUserId
															from  acc.tblDocumentRecord_Header1 
															cross apply
																		(select row_Number()over(order by h1.fldtypesanadId, h1.fldTarikhDocument,h1.fldDate)Shomare
																		,h1.fldid --,fldTypeSanadId
																		from acc.tblDocumentRecord_Header as h
																		inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
																		inner join acc.tblFiscalYear f on f.fldid =fldFiscalYearId
																		where h.fldorganId=@fldOrganId and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldModuleSaveId
																		and h1.fldDocumentNum<>0
																		)t
															where tblDocumentRecord_Header1.fldid=t.fldid
																if (@@error<>0)
																rollback
											
														end
													end
							end

						end
			end
	end
	end
  commit
GO
