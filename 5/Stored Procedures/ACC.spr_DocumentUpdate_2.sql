SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentUpdate_2]
	
	 @fldId int,
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
	@fldFiscalYearId int,
	@fldTypeSanad int/*,
	@Detail Acc.DocumentDetail readOnly*/
as
/*begin tran

	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @t table (id int ,cod int identity)
	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @headerID int , @fldDetailID int ,@fldCaseId int,@flag bit=0
	
	exec  [ACC].[spr_DocumentDetailDelete] @fldId,@fldUserId --دیلیت از همه جدولای سند 
	if (@@error<>0)
		rollback
	else
	begin
	select @headerID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
	INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId], [fldDocumentNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId],[fldTarikhDocument], [fldDesc], [fldDate], [fldIP], [fldUserId],[fldAccept],fldType,fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldFiscalYearId,fldTypeSanadId)
	--output inserted.fldId
	SELECT @headerID, @fldDocumentNum, @fldArchiveNum, @fldDescriptionDocu,@fldOrganId,@fldTarikhDocument ,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldType,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,@fldFiscalYearId ,@fldTypeSanad
	if (@@ERROR<>0)
		ROLLBACK
	else
	Begin

			select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
			INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
			output inserted.fldid into @t
			SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, '', GETDATE(), @fldIP, @fldUserId from @detail
			where fldSourceId<>0
			if (@@ERROR<>0)
			begin
				ROLLBACK
				set @flag=1
			end
		if (@flag=0)
			begin
			select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				SELECT row_number() over (order by (select 1))+@fldDetailID, @headerID, fldCodingId, fldDescription, fldBedehkar, fldBestankar, fldCenterCoId, id, @fldDesc, GETDATE(), @fldIP, @fldUserId from 
				@t t
				cross apply (select row_number() over (order by (select 1))c,* from @detail where fldSourceId<>0)t1
				where t1.c=t.cod
				if (@@ERROR<>0)
					ROLLBACK
			end
		if (@flag=0)
			begin
			select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
				INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				SELECT row_number() over (order by (select 1))+@fldDetailID, @headerID, fldCodingId, fldDescription, fldBedehkar, fldBestankar, fldCenterCoId, NULL, @fldDesc, GETDATE(), @fldIP, @fldUserId from 
				 @detail where fldSourceId=0
				if (@@ERROR<>0)
					ROLLBACK
			end

	end
end
	commit*/
GO
