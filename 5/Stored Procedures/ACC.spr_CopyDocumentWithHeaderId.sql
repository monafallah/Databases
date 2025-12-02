SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  proc [ACC].[spr_CopyDocumentWithHeaderId]( @fldId int,@fldUserId int ,@fldIP nvarchar(15))
as
begin try
begin tran
	--declare @fldId int,@fldUserId int ,@fldIP nvarchar(15)
	
	declare @ID int , @fldDetailID int ,@logId int,@ModuleSaveId int,@Document_HedearId int=0
	,@fldDocumentNum int,@fldType tinyint,@fldFiscalYearId int,@fldTypeSanadId tinyint,@organid int
	,@NewId int,@NewHeader1 int,@fileDuc int,@erorid int

	select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
	where fldId=@fldId

	select @fldType=h.fldType,@fldFiscalYearId=h.fldFiscalYearId,@fldTypeSanadId=h1.fldTypeSanadId,@ModuleSaveId=h1.fldModuleSaveId 
	,@organid=h.fldOrganId
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
		where h.fldOrganId=@organid and tblFiscalYear.fldid=@fldFiscalYearId
		and h1.fldModuleSaveId=@ModuleSaveId

		if(@fldDocumentNum=1)
			set @fldDocumentNum=2
	end
	/*Header*/
	select @NewId =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
	INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
	SELECT @NewId,   h.fldDescriptionDocu,h.fldYear,h.fldOrganId,h.fldDesc, GETDATE(), @fldIP, @fldUserId,h.fldType,h.fldFiscalYearId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h1.fldId=@fldId
	/*Header1*/
	select @NewHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
	INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid)
	SELECT @NewHeader1,@NewId, @fldDocumentNum, h1.fldArchiveNum, h1.fldTarikhDocument , GETDATE(), @fldIP, @fldUserId,h1.fldAccept,h1.fldModuleSaveId ,h1.fldModuleErsalId,h1.fldShomareFaree,h1.fldTypeSanadId,h1.fldPId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h1.fldId=@fldId

	/*Detail*/
	select @fldDetailID =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecord_Details] 
	INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId], [fldDocument_HedearId1],[fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
	select row_number()over (order by d.fldDocument_HedearId) +@fldDetailID,@NewId,case when [fldDocument_HedearId1] is not null then  @NewHeader1 else null end,d.fldCodingId,d.fldDescription,d.fldBedehkar,d.fldBestankar,d.fldCenterCoId,d.fldCaseId,d.fldDesc,getdate(),@fldIP,@fldUserId,d.fldOrder 
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentRecord_Details d on d.fldDocument_HedearId=h.fldid
	where h1.fldId=@fldId

	/*file*/
	/*select @fileDuc =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecorde_File] 
	INSERT INTO [ACC].[tblDocumentRecorde_File] ([fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate],fldIP)
	select row_number()over (order by d.fldDocument_HedearId)+@fileDuc,@NewId,d.fldFileId,@fldUserId,d.fldDesc,getdate(),@fldIP
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentRecorde_File d on d.fldDocumentHeaderId=h.fldid
	where h1.fldId=@fldId*/
select 0 as ErrorCode ,'' as Error_Msg
commit
end try

begin catch
rollback
select @erorid=max(isnull(fldid,0))+1 from com.tblError
insert into com.tblError
select max(isnull(fldid,0))+1,'',ERROR_MESSAGE(),dbo.Fn_AssembelyMiladiToShamsi(getdate()),@fldIP,@fldUserId,'',GETDATE()
 from Com.tblError
 select @erorid as ErrorCode,N'خطایی با شماره'+ cast(@erorid as varchar(10))+N'رخ داده است.' Error_Msg



end catch 
GO
