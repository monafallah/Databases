SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [ACC].[spr_tblArtiklMapInsert2] 

    @fldBankBillId int,
	@fldFiscalYearId int,
    @fldDocumentRecord_DetailsId varchar(max),
	@fldModuleSaveId int,
	@fldModuleErsalId int,
	@fldOrganId int,
    @fldDesc nvarchar(MAX),
	@fldIP varchar(16),
    @fldUserId int
AS	 
begin try	
	BEGIN TRAN
	declare @fldid int,@id int
	
	
	declare @fldDocumentNum int, 
			@fldArchiveNum NVARCHAR(50),
			@fldShomareFaree int,
			@fldDescriptionDocu nvarchar(MAX),
			@fldTarikhDocument CHAR(10),--=[Com].[MiladiTOShamsi](getdate()),
			@fldAccept tinyint=0,
			@fldType tinyint=1,
			@ItemMojodiNazdeBank int=19,
			@ItemAsnadDaryaftani int=14

			declare @fldDetailID int ,@fldCaseId int=0,@flag bit=0,@logId int,@IDHeader1 int=0,@fldyear smallint=0,@ShakhsId int
		,@CodeAvarez int,@CodeMaliyat int,@CodeMojodiNazdeBank int,@CodeAsnadDaryaftani int,@CodingHeader int,@Mablagh int =0,@SourceId int=0,@ShomareHesab varchar(50)=''
		
		select @Mablagh=case when fldBedehkar>0 then fldBedehkar else fldBestankar end ,@SourceId=fldShomareHesabId 
		,@fldTarikhDocument=fldTarikh
		from acc.tblBankBill_Details as d
			inner join acc.tblBankBill_Header as h on h.fldid=d.fldHedearId
			where d.fldId=@fldBankBillId

		select @ShomareHesab=fldShomareHesab from com.tblShomareHesabeOmoomi where fldid=@SourceId
		
		select @fldyear=fldYear from acc.tblFiscalYear where fldid=@fldFiscalYearId
		select @CodingHeader=fldId from Acc.tblCoding_Header
		where fldYear=@fldyear

		 select @CodeAsnadDaryaftani=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemAsnadDaryaftani and c.fldHeaderCodId=@CodingHeader

		  select @CodeMojodiNazdeBank=c.fldId from acc.tblTemplateCoding as t
		 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
		 where t.fldItemId=@ItemMojodiNazdeBank and c.fldHeaderCodId=@CodingHeader

	set @fldDescriptionDocu=N'واریزی فیش به شماره حساب  '+@ShomareHesab
	select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
					 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
					and h1.fldModuleSaveId=@fldModuleSaveId	
	
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
			INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
			SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldType,@fldFiscalYearId

			select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
			INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
			SELECT @IDHeader1,@fldID, @fldDocumentNum, @fldArchiveNum, @fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,2,null

		--select 300.0/800*400,500.0/800*400
		/*اینزرت آرتیکل های مپ شده به عنوان  حساب های دریافتنی  بستانکار*/
		declare @t table(id int)
		select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						--output inserted.fldid into @t
						SELECT row_number() over (order by (select 1))+@fldDetailID, @fldId,@IDHeader1, @CodeAsnadDaryaftani, t.fldDescription, 0, fldBedehkar, fldCenterCoId, fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,fldOrder 
						from com.Split(@fldDocumentRecord_DetailsId,',') as s
						inner join acc.tblDocumentRecord_Details as t on t.fldId=s.Item
						where Item<>''
		
		/*مبلغ جدول بدهکار جدول بانک بیل به عنوان بدهکار موجودی نزد بانک اینزرت میشه*/
			

			select @fldCaseId=fldId from [ACC].[tblCase] where fldCaseTypeId=5 and fldSourceId=@SourceId
			if(@fldCaseId=0 or @fldCaseId is null)
			begin
				select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
				INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
							SELECT @fldCaseId, 5, @SourceId, '', GETDATE(), @fldIP, @fldUserId 
			end		
		 select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @CodeMojodiNazdeBank, @fldDescriptionDocu,@Mablagh, 0, null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						
		select @id=isnull(max(fldId),0)+1  FROM   [ACC].[tblArtiklMap] 
		INSERT INTO [ACC].[tblArtiklMap] ([fldId], [fldBankBillId], [fldDocumentRecord_DetailsId], [fldDate], [fldIP], [fldUserId])
		SELECT @Id, @fldBankBillId, @fldDetailID, getdate(), @fldIP, @fldUserId
		--SELECT ROW_NUMBER() over (order by id)+@Id, @fldBankBillId, id, getdate(), @fldIP, @fldUserId
		--from @t

		select '' as ErrorCode,'' as ErrorMessage
	commit tran
end try
begin catch
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
end catch
GO
