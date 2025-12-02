SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentInsertCheck_JOB]
as
begin try
	begin tran
		declare @Tarikh nvarchar(10)
		set @Tarikh=dbo.Fn_AssembelyMiladiToShamsi( DATEDIFF(day,-2, GETDATE()))

		DECLARE @id INT, @mablagh int,@fldOrganId int,@fldFiscalYearId int,@fldModuleSaveId int=10,@fldModuleErsalId INT=10,@fldID int
		,@fldyear smallint,@fldAccept TINYINT=0,@IDHeader1 int,@fldType tinyint=1,@fldDetailID int,@CodingHeader int,@fldCaseId int
		,@Code25 int,@Code26 int,@Code29 int,@Code30 int,@fldTypeSanad bit
		,@fldTarikhDocument varchar(10)=dbo.Fn_AssembelyMiladiToShamsi( GETDATE()),@fldDocumentNum int
		,@fldDescriptionDocu nvarchar(500)=N'بابت تغییر طبقه بندی اسناد دریافتی از مودیان'

		set @fldyear=SUBSTRING(@fldTarikhDocument,1,4)

		DECLARE @getid CURSOR

		SET @getid = CURSOR FOR
		select fldId,fldMablaghSanad,fldOrganId,fldTypeSanad from drd.tblCheck
		where fldTarikhSarResid=@Tarikh

		OPEN @getid
		FETCH NEXT
		FROM @getid INTO @id, @mablagh,@fldOrganId,@fldTypeSanad
		WHILE @@FETCH_STATUS = 0
		BEGIN
			if(@fldTypeSanad=0)
			begin
				select @fldFiscalYearId=fldId from acc.tblFiscalYear where fldYear=@fldyear and fldOrganId=@fldOrganId

				select @CodingHeader=fldId from Acc.tblCoding_Header where fldYear=@fldyear and fldOrganId=@fldOrganId

					select @Code25=c.fldId from acc.tblTemplateCoding as t
					 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
					 where t.fldItemId=25 and c.fldHeaderCodId=@CodingHeader

					  select @Code26=c.fldId from acc.tblTemplateCoding as t
					 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
					 where t.fldItemId=26 and c.fldHeaderCodId=@CodingHeader

					  select @Code29=c.fldId from acc.tblTemplateCoding as t
					 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
					 where t.fldItemId=29 and c.fldHeaderCodId=@CodingHeader

					  select @Code30=c.fldId from acc.tblTemplateCoding as t
					 inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
					 where t.fldItemId=30 and c.fldHeaderCodId=@CodingHeader

					 /*با کدینگ 25و29*/
					select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
								 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
								inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
								where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
								and h1.fldModuleSaveId=@fldModuleSaveId
		
						select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
						INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
						SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,N'', GETDATE(), N'1', 1,@fldType,@fldFiscalYearId

						select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
						INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
						SELECT @IDHeader1,@fldID, @fldDocumentNum, null, @fldTarikhDocument , GETDATE(), N'1', 1,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,null,2,null,2
		
					select @fldCaseId=fldId from [ACC].[tblCase] where fldCaseTypeId=3 and fldSourceId=@id
					if(@fldCaseId is null or @fldCaseId=0)
					begin
						select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
									INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
									SELECT @fldCaseId, 3, @id, '', GETDATE(), N'1', 1 
					
					end

					select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
		
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @Code25, @fldDescriptionDocu, 0, @mablagh, null, @fldCaseId, N'', GETDATE(), N'1', 1,2

						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT 1+@fldDetailID, @fldId,@IDHeader1, @Code29, @fldDescriptionDocu, @mablagh, 0, null, @fldCaseId, N'', GETDATE(), N'1', 1,1
						
						select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
		
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @Code26, @fldDescriptionDocu, @mablagh, 0, null, @fldCaseId, N'', GETDATE(), N'1', 1,3

						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT 1+@fldDetailID, @fldId,@IDHeader1, @Code30, @fldDescriptionDocu, 0, @mablagh, null, @fldCaseId, N'', GETDATE(), N'1', 1,4

						
						
						--------------------------------------------------------------
						/*کدینگ 26و30*/
						/*select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
								 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
								inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
								where h.fldOrganId=@fldOrganId and tblFiscalYear.fldid=@fldFiscalYearId
								and h1.fldModuleSaveId=@fldModuleSaveId
		
						select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
						INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
						SELECT @fldId,   @fldDescriptionDocu,@fldyear,@fldOrganId,N'', GETDATE(), N'1', 1,@fldType,@fldFiscalYearId

						select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
						INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
						SELECT @IDHeader1,@fldID, @fldDocumentNum, null, @fldTarikhDocument , GETDATE(), N'1', 1,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,null,2,null,2
		
						select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
		
						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT @fldDetailID, @fldId,@IDHeader1, @Code26, @fldDescriptionDocu, @mablagh, 0, null, @fldCaseId, N'', GETDATE(), N'1', 1,1

						INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
						SELECT 1+@fldDetailID, @fldId,@IDHeader1, @Code30, @fldDescriptionDocu, 0, @mablagh, null, @fldCaseId, N'', GETDATE(), N'1', 1,2
						*/--------------------------------------------------------------
				end
	FETCH NEXT
	FROM @getid INTO @id, @mablagh,@fldOrganId,@fldTypeSanad
END

		CLOSE @getid
		DEALLOCATE @getid
	select 0 as ErrorCode,'' as ErrorMessage
	commit tran
end try
begin catch
rollback
declare @IdError int=0
select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),N'1',1,'spr_DocumentInsertCheck_JOB',getdate() from com.tblUser where fldid=1
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
end catch
GO
