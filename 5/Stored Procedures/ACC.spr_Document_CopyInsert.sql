SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_Document_CopyInsert]
@fldId int,
@fldOrganId int,
@fldModuleErsalId int,
@fldModuleSaveId int,
@fldTypeInsert tinyint,
@fldTarikhDocument varchar(10),
@fldIP varchar(16),
@fldUserId int

	

	as
	begin tran
	declare @t table (id int ,cod int identity)
	declare @ID int , @fldDetailID int ,@fldCaseId int,@flag bit=0,@logId int,@ModuleSaveId int,@Document_HedearId int=0
	,@fldDocumentNum int,@fldType tinyint,@fldFiscalYearId int,@fldTypeSanadId tinyint

	select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
	where fldId=@fldId

	select @fldType=h.fldType,@fldFiscalYearId=h.fldFiscalYearId,@fldTypeSanadId=h1.fldTypeSanadId,@ModuleSaveId=h1.fldModuleSaveId 
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h1.fldId=@fldId
	
	if(@fldType=2)
		set @fldDocumentNum=0
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

	
	select @ID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
	if(@fldTypeInsert=1)/*ارسال سند به حسابداری*/
	begin
			if (@fldModuleErsalId=4 and @fldModuleSaveId=10)
			begin
					INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
					SELECT @Id,fldDocument_HedearId, @fldDocumentNum, fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,fldAccept,@fldModuleSaveId ,@fldModuleSaveId,fldShomareFaree,fldTypeSanadId,fldid
					from acc.tblDocumentRecord_Header1 where fldId=@fldId
					if (@@ERROR<>0)
						ROLLBACK
				else
				
						update acc.tblDocumentRecord_Header1 set fldModuleErsalId=@fldModuleSaveId,fldPId=@id
						where fldId=@fldId
				
				
			end
			else
			begin
				INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
				SELECT @Id,fldDocument_HedearId, @fldDocumentNum, fldArchiveNum,@fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,fldAccept,@fldModuleSaveId ,@fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldid
				from acc.tblDocumentRecord_Header1 where fldId=@fldId
				if (@@ERROR<>0)
					ROLLBACK
				--else
				
				--		update acc.tblDocumentRecord_Header1 set fldModuleErsalId=@fldModuleErsalId,fldPId=@id
				--		where fldId=@fldId


			end	
			
			/*else 
			Begin

					/*select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
					INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
					output inserted.fldid into @t
					SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, '', GETDATE(), @fldIP, @fldUserId from 
					acc.tblDocumentRecord_Details as d
					inner join acc.tblCase as c on c.fldId=d.fldCaseId
					where fldDocument_HedearId=@Document_HedearId and  fldSourceId<>0
					if (@@ERROR<>0)
					begin
						ROLLBACK
						set @flag=1
					end*/
				--if (@flag=0)
					--begin
					select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT row_number() over (order by (select 1))+@fldDetailID, @Id, fldCodingId, fldDescription, fldBedehkar, fldBestankar, fldCenterCoId, fldCaseId, fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder 
						--from 
						--@t t
						--cross apply (select row_number() over (order by (select 1))c,d.*								
						from acc.tblDocumentRecord_Details as d
									--inner join acc.tblCase as c on c.fldId=d.fldCaseId 
									where fldDocument_HedearId=@Document_HedearId --and  fldSourceId<>0)t1
						--where t1.c=t.cod
						if (@@ERROR<>0)
							ROLLBACK
					--end
				--if (@flag=0)
				--	begin
				--		select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				--		INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				--		SELECT row_number() over (order by (select 1))+@fldDetailID, @Id, fldCodingId, fldDescription, fldBedehkar, fldBestankar, fldCenterCoId, NULL, d.fldDesc, GETDATE(), @fldIP, @fldUserId ,fldorder  
				--		 from acc.tblDocumentRecord_Details as d
				--					left join acc.tblCase as c on c.fldId=d.fldCaseId 
				--		 where fldDocument_HedearId=@Document_HedearId and   (fldSourceId=0 or d.fldCaseId  is null)
				--		if (@@ERROR<>0)
				--			ROLLBACK
				
					
				--	end

			end*/
	end
	else
	begin
	INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
			SELECT @Id,fldDocument_HedearId, @fldDocumentNum, fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,fldAccept,@fldModuleSaveId ,@fldModuleErsalId,fldShomareFaree,3,fldPId
			from acc.tblDocumentRecord_Header1 where fldId=@fldId
			if (@@ERROR<>0)
				ROLLBACK
			
			else
			Begin

				--	select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
				--	INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				--	output inserted.fldid into @t
				--	SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, '', GETDATE(), @fldIP, @fldUserId from 
				--	acc.tblDocumentRecord_Details as d
				--	inner join acc.tblCase as c on c.fldId=d.fldCaseId
				--	where fldDocument_HedearId=@Document_HedearId and  fldSourceId<>0
				--	if (@@ERROR<>0)
				--	begin
				--		ROLLBACK
				--		set @flag=1
				--	end
				--if (@flag=0)
					--begin
					select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT row_number() over (order by (select 1))+@fldDetailID, @Document_HedearId,@ID, fldCodingId, fldDescription, fldBestankar , fldBedehkar, fldCenterCoId, fldCaseId, fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder 
						--from 
						--@t t
						--cross apply (select row_number() over (order by (select 1))c,d.*								
						from acc.tblDocumentRecord_Details as d
									--inner join acc.tblCase as c on c.fldId=d.fldCaseId 
									where fldDocument_HedearId1=@fldId or 
									(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@fldId ) 
									and fldDocument_HedearId=@Document_HedearId  and d.fldDocument_HedearId1 is null)--and  fldSourceId<>0)t1
						--where t1.c=t.cod
						if (@@ERROR<>0)
							ROLLBACK
					--end
				--if (@flag=0)
				--	begin
				--		select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				--		INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
				--		SELECT row_number() over (order by (select 1))+@fldDetailID, @Id, fldCodingId, fldDescription, fldBestankar, fldBedehkar, fldCenterCoId, NULL, d.fldDesc, GETDATE(), @fldIP, @fldUserId ,fldorder  
				--		 from acc.tblDocumentRecord_Details as d
				--					left join acc.tblCase as c on c.fldId=d.fldCaseId 
				--		 where fldDocument_HedearId=@Document_HedearId and   (fldSourceId=0 or d.fldCaseId  is null)
				--		if (@@ERROR<>0)
				--			ROLLBACK
				
					
				--	end

			end
	end
  commit
GO
