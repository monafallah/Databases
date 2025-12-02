SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentUpdate]
	
	 @fldHeaderId int,
	@fldDocumentNum int,
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
	@fldTypeSanad int,
	@Detail Acc.DocumentDetailUpdate readOnly
  
as
begin tran

	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)

	declare @flag bit=0, @fldCaseId int,@fldFiscalYearId int,@fldDetailID int,@logId int,@_DucNum int,@Document_HedearId int=0
	declare @t table (id int ,cod int identity)
	declare @t1 table (id int,CaseTypeId int,SourceId int ,cod int identity)
	declare @Delete table (idDetail int,caseid int)

	select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
	where fldId=@fldHeaderId

	/*Delete*/
	insert @Delete 
	select dd.fldid,dd.fldCaseId from acc.tblDocumentRecord_Details dd
	left join @Detail d  on d.fldid=dd.fldid
	 where dd.fldDocument_HedearId=@Document_HedearId  
			and (fldDocument_HedearId1=@fldHeaderId or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@fldHeaderId ) and fldDocument_HedearId1 is null )) 
	 and d.fldid is null
	
	DELETE detail
		FROM   [ACC].[tblDocumentRecord_Details] detail
		inner join @Delete t on t.idDetail=detail.fldid
		--WHERE  fldDocument_HedearId = @Document_HedearId
		--and (fldDocument_HedearId1=@fldHeaderId or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@fldHeaderId ) and fldDocument_HedearId1 is null )) 
		if (@@error<>0)
		begin
			rollback
			set @flag=1
			
		end
		--if (@flag=0)
		begin

			delete c from acc.tblCase as c
			left join [ACC].[tblDocumentRecord_Details] d   on  d.fldCaseId=c.fldid
			where d.fldCaseId is null

		

			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end

		/*if (@flag=0)
		begin
			delete c from acc.tblCase as c
			inner join @Delete  t on  t.caseid=c.fldid
			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end*/

----------------------------------------------------------------------------------
/*Update*/
	select @fldFiscalYearId=fldfiscalyearId,@fldDocumentNum=fldDocumentNum from [ACC].[tblDocumentRecord_Header] as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h1.fldid=@fldHeaderId

	
	

	if (@flag=0)
	begin
		if(@fldModuleSaveId=10 and exists (select * from acc.tblDocumentRecord_Header1 where fldPId=@fldHeaderId and fldModuleSaveId=4))
		begin
		if(@fldType=2)
		set @fldDocumentNum=0
	else if(@fldModuleSaveId<>4 and @fldDocumentNum=0)
	begin
			select @fldDocumentNum=ISNULL(max(fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
			 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
			 inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
			and fldModuleSaveId=@fldModuleSaveId
		
	end
	else if (@fldTypeSanad=1) /*افتتاحیه*/
	set @fldDocumentNum=1
		

	else if( @fldDocumentNum=0)
	begin 
		select  @fldDocumentNum= max(isnull(fldDocumentNum,0))+1 from  [ACC].[tblDocumentRecord_Header] as h
		 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
		 inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
		where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
		and fldModuleSaveId=@fldModuleSaveId
			
			if (@fldDocumentNum=1)
				set @fldDocumentNum=2
	end	
	else
		set @fldDocumentNum=@fldDocumentNum+1

			declare  @IDHeader1 int=0
			select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
			INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
			SELECT @IDHeader1,@Document_HedearId, @fldDocumentNum, fldArchiveNum, fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,fldAccept,fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,3,fldPid
			from [ACC].[tblDocumentRecord_Header1]
			WHERE  fldId = @fldHeaderId
			if (@@ERROR<>0)
				ROLLBACK 
			else
			begin
				select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],fldDocument_HedearId1, [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				SELECT row_number() over (order by (select 1))+@fldDetailID, @Document_HedearId,@IDHeader1, fldCodingId, fldDescription, fldBestankar, fldBedehkar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, fldCaseId, fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder from 
				 [ACC].[tblDocumentRecord_Details] as d
				WHERE fldDocument_HedearId1=@fldHeaderId or 
						(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@fldHeaderId ) 
						and fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)
				
					if (@@ERROR<>0)
						ROLLBACK
			end
			if(@fldType=2)
				set @fldDocumentNum=0
			else if(@fldModuleSaveId<>4 and @fldDocumentNum=0)
			begin
					select @fldDocumentNum=ISNULL(max(fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
						inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
						inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					and fldModuleSaveId=@fldModuleSaveId
					

			end
			else if (@fldTypeSanad=1) /*افتتاحیه*/
				set @fldDocumentNum=1
			else if( @fldDocumentNum=0)
			begin 
				select  @fldDocumentNum= max(isnull(fldDocumentNum,0))+1 from  [ACC].[tblDocumentRecord_Header] as h
					inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
				where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
				and fldModuleSaveId=@fldModuleSaveId
			
					if (@fldDocumentNum=1)
						set @fldDocumentNum=2
			end
			else
				set @fldDocumentNum=@fldDocumentNum+1
				set @IDHeader1=0
			select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
			INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
			--output inserted.fldId
			SELECT @IDHeader1,@Document_HedearId, @fldDocumentNum, @fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,@fldTypeSanad,fldPId
			from [ACC].[tblDocumentRecord_Header1]
			WHERE  fldId = @fldHeaderId
			if (@@ERROR<>0)
				ROLLBACK 
			else
			begin
				select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
				INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				output inserted.fldid into @t
				SELECT row_number()over (order by (select 1  ))+@fldCaseId, d.fldCaseTypeId, d.fldSourceId, '', GETDATE(), @fldIP, @fldUserId 
				from @Detail as d
				left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
				where d.fldSourceId<>0 and c.fldId is null
				group by d.fldCaseTypeId, d.fldSourceId
				--where fldSourceId<>0 and fldCaseId=0 and   fldid<>0
				if (@@ERROR<>0)
				begin
					ROLLBACK
				end
				else
				begin
					select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
					INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],fldDocument_HedearId1, [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
					SELECT row_number() over (order by (select 1))+@fldDetailID, @Document_HedearId,@IDHeader1, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, c.fldId, '', GETDATE(), @fldIP, @fldUserId,fldOrder from 
					@Detail as d					
					left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
					if (@@ERROR<>0)
						ROLLBACK
				end
			end
		end
		else
		begin
			if(@fldType=2)
				set @fldDocumentNum=0
			else if(@fldModuleSaveId<>4 and @fldDocumentNum=0)
			begin
				select @fldDocumentNum=ISNULL(max(fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
					inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
				where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
				and fldModuleSaveId=@fldModuleSaveId
				--if( @fldDocumentNum=0)
				--	set @fldDocumentNum=1
				end
				else if (@fldTypeSanad=1) /*افتتاحیه*/
				set @fldDocumentNum=1
					--select @fldDocumentNum=1 from  [ACC].[tblDocumentRecord_Header] as h
					-- inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					--inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					--where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					--and fldModuleSaveId=@fldModuleSaveId --and fldDocumentNum=0

				else if( @fldDocumentNum=0)
				begin 
					select  @fldDocumentNum= max(isnull(fldDocumentNum,0))+1 from  [ACC].[tblDocumentRecord_Header] as h
						inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
						inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					and fldModuleSaveId=@fldModuleSaveId
			
						if (@fldDocumentNum=1)
							set @fldDocumentNum=2
				end	
			UPDATE [ACC].[tblDocumentRecord_Header]
			SET     [fldDescriptionDocu] = @fldDescriptionDocu,[fldOrganId]=@fldOrganId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
			,fldType=@fldType
			WHERE  [fldId] = @Document_HedearId
		
			if (@@error<>0)
				rollback
		else
			begin
			UPDATE [ACC].[tblDocumentRecord_Header1]
			SET    [fldArchiveNum] = @fldArchiveNum, [fldTarikhDocument]=@fldTarikhDocument, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId,[fldAccept]=@fldAccept
			,fldModuleSaveId=@fldModuleSaveId,fldModuleErsalId=@fldModuleErsalId,fldTypeSanadId=@fldTypeSanad,fldDocumentNum=@fldDocumentNum
			,fldShomareFaree=@fldShomareFaree
			WHERE  fldId = @fldHeaderId
			if (@@error<>0)
				rollback	
			else
			begin
				 
				select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
				INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				output inserted.fldid into @t
				SELECT row_number()over (order by (select 1  ))+@fldCaseId, d.fldCaseTypeId, d.fldSourceId, '', GETDATE(), @fldIP, @fldUserId from @Detail as d
				left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
				where d.fldSourceId<>0 and c.fldId is null
				group by d.fldCaseTypeId, d.fldSourceId
				--where fldSourceId<>0 and fldCaseId=0 and   fldid<>0
				if (@@ERROR<>0)
				begin
					ROLLBACK
					set @flag=1
				end
				if (@flag=0)
				begin
					UPDATE [ACC].[tblDocumentRecord_Details]
					SET     [fldCodingId] = d.fldCodingId, [fldDescription] = d.fldDescription, [fldBedehkar] = d.fldBedehkar, [fldBestankar] = d.fldBestankar, [fldCenterCoId] =d.fldCenterCoId
					, [fldCaseId] = c.fldId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
					,fldOrder=d.fldOrder
					from [ACC].[tblDocumentRecord_Details] 
					inner join @detail d on [tblDocumentRecord_Details].fldid=d.fldid
					left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
					--cross apply (select  * from (select row_number() over (order by (select 1))c,* from @detail d where fldSourceId<>0  and fldCaseId=0
					--			)t1
					--inner join @t t on 	 t1.c=t.cod)detail
					--where  detail.fldDocument_HedearId=[tblDocumentRecord_Details].fldDocument_HedearId
					--and [tblDocumentRecord_Details].fldid=detail.fldid
					if (@@error<>0)
					begin
						rollback
						set @flag=1
					end
				end
			
				/*if(@flag=0)
				begin
					UPDATE [ACC].[tblCase]
					SET    [fldCaseTypeId] = d.fldCaseTypeId, [fldSourceId] = d.fldSourceId, [fldDesc] = '', [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
					from [ACC].[tblCase] inner join 
					@Detail d on d.fldCaseId=tblCase.fldid
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end
				end*/
				/*if (@flag=0)
				begin
					SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
					UPDATE [ACC].[tblDocumentRecord_Details]
					SET     [fldCodingId] = d.fldCodingId, [fldDescription] = d.fldDescription, [fldBedehkar] = d.fldBedehkar, [fldBestankar] = d.fldBestankar, [fldCenterCoId] = d.fldCenterCoId/*, [fldCaseId] = d.fldCaseId*/, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
					,fldOrder=d.fldOrder
					from  [ACC].[tblDocumentRecord_Details] inner join @Detail d on 	
					[tblDocumentRecord_Details].fldid=d.fldid
					if (@@error<>0)
					begin	
						rollback
						set @flag=1
					end
				end*/
	----------------------------------------------------------------------------	
		/*insert*/	
				/*if (@flag=0)
				begin
					select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
					INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
					output inserted.fldid,inserted.fldCaseTypeId,inserted.fldSourceId into @t1
					SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, '', GETDATE(), @fldIP, @fldUserId 
					from @detail
					where fldSourceId<>0 and fldid=0
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end
				end
				if (@flag=0)/*ویرایش رکوردی که قبل کیس نداشته*/
				begin
					select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
					INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
					output inserted.fldid,inserted.fldCaseTypeId,inserted.fldSourceId into @t1
					SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, fldId, GETDATE(), @fldIP, @fldUserId 
					from @detail
					where fldSourceId<>0 and fldid<>0 and fldCaseId =0
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end
				end*
				if (@flag=0)/*ویرایش رکوردی که قبل کیس نداشته*/
				begin
					SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
					UPDATE [ACC].[tblDocumentRecord_Details]
					SET       [fldCaseId] = c.fldId
					from  [ACC].[tblDocumentRecord_Details] inner join [ACC].[tblCase]  c on 	
					[tblDocumentRecord_Details].fldid=c.fldDesc
					if (@@error<>0)
					begin	
						rollback
						set @flag=1
					end
				end*/
				if (@flag=0)
				begin
					select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
					INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
					SELECT row_number() over (order by (select 1))+@fldDetailID, @Document_HedearId, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, c.fldId, @fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder 
					from @detail as d
					left join acc.tblCase as c on c.fldCaseTypeId=d.fldCaseTypeId and c.fldSourceId=d.fldSourceId
					where d.fldId=0
					--from @t1 t
					--cross apply (select row_number() over (order by (select 1))c,* from @detail where fldSourceId<>0 and fldId=0)t1
					--where t1.c=t.cod and t.CaseTypeId=t1.fldCaseTypeId and t.SourceId=t1.fldSourceId
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end
				end
				/*if (@flag=0)
				begin
					select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
					INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
					SELECT row_number() over (order by (select 1))+@fldDetailID, @Document_HedearId, fldCodingId, fldDescription, fldBedehkar, fldBestankar, CASE WHEN fldCenterCoId=0 THEN NULL ELSE fldCenterCoId end, NULL, @fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder from 
					@detail where fldSourceId=0 and fldid=0
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end

				end*/
	------------------------------------------------------------------------------------
	/*UpdateAccept*/				
				if (@flag=0)
					if (@fldTypeSanad=4)
						begin
							update h1 
							set fldAccept=1
							from [ACC].[tblDocumentRecord_Header1]   h1
							--	inner join [ACC].[tblDocumentRecord_Header]  h on h.fldId=h1.fldDocument_HedearId
							--where h.fldOrganId =@fldOrganId and fldModuleSaveId=@fldModuleSaveId and fldFiscalYearId=@fldFiscalYearId and fldtype=1
							--and fldAccept=0
							where fldid=@fldHeaderId
							if (@@error<>0)
								rollback
							else
							begin
								select @logId =ISNULL(max(fldId),0) from [ACC].tblDocument_HeaderLog 
								insert into Acc.tblDocument_HeaderLog(fldid,fldHeaderId,fldUserId,fldDate)
								select row_number()over (order by h1.fldid)+@logId,h1.fldid,@fldUserId,getdate() 
								from 
								--acc.tblDocumentRecord_Header h inner join
									 [ACC].[tblDocumentRecord_Header1]  h1 --on h.fldId=h1.fldDocument_HedearId
								where  fldid=@fldHeaderId
								--h.fldOrganId =@fldOrganId and fldModuleSaveId=@fldModuleSaveId and fldFiscalYearId=@fldFiscalYearId and fldtype=1 and fldAccept=1
								and not exists(select * from acc.tblDocument_HeaderLog where fldHeaderId=h1.fldid)
								if (@@ERROR<>0)
									rollback
							end
						end
					
				end
			end
		end	
	end


	

	commit
GO
