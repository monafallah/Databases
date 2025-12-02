SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_DocumentUpdate_1]
	
	 @fldId int,
	 @fldDocumentNum int,
    @fldAtfNum int,
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
	@fldModuleErsalId int/*,
	@Detail Acc.DocumentDetailUpdate readOnly*/
   /* @fldArchiveNum NVARCHAR(50),
    @fldDescriptionDocu nvarchar(MAX),
    @fldOrganId INT,
    @fldTarikhDocument CHAR(10),
   	@fldModuleSaveId int,
	@fldModuleErsalId int,
	@fldAccept tinyint,
	@fldType tinyint,
	@fldCodingId int,
    @fldDescription nvarchar(MAX),
    @fldBedehkar bigint,
    @fldBestankar bigint,
    @fldCenterCoId int,
    @fldCaseId int,
	@fldCaseTypeId int,
	@fldSourceId int,
	@fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int*/
as
/*begin tran

	SET @fldDescriptionDocu=Com.fn_TextNormalize(@fldDescriptionDocu)
	--SET @fldDescription=Com.fn_TextNormalize(@fldDescription)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)

	declare @flag bit=0, @fldCaseId int
	declare @t table (id int ,cod int identity)
	UPDATE [ACC].[tblDocumentRecord_Header]
	SET    [fldId] = @fldId, [fldArchiveNum] = @fldArchiveNum, [fldDescriptionDocu] = @fldDescriptionDocu,[fldOrganId]=@fldOrganId,[fldTarikhDocument]=@fldTarikhDocument, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId,[fldAccept]=@fldAccept
	,fldType=@fldType,fldModuleSaveId=@fldModuleSaveId,fldModuleErsalId=@fldModuleErsalId
	WHERE  [fldId] = @fldId

	if (@@error<>0)
		rollback
	else
	begin
		
				select @fldCaseId =ISNULL(max(fldId),0) from [ACC].[tblCase] 
				INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
				output inserted.fldid into @t
				SELECT row_number()over (order by (select 1  ))+@fldCaseId, fldCaseTypeId, fldSourceId, '', GETDATE(), @fldIP, @fldUserId from @Detail
			
				where fldSourceId<>0 and fldCaseId=0
				if (@@ERROR<>0)
				begin
					ROLLBACK
					set @flag=1
				end
				if (@flag=0)
				begin
					UPDATE [ACC].[tblDocumentRecord_Details]
					SET     [fldCodingId] = detail.fldCodingId, [fldDescription] = detail.fldDescription, [fldBedehkar] = detail.fldBedehkar, [fldBestankar] = detail.fldBestankar, [fldCenterCoId] =detail.fldCenterCoId, [fldCaseId] = id, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
					from [ACC].[tblDocumentRecord_Details] 
					cross apply (select  * from (select row_number() over (order by (select 1))c,* from @detail d where fldSourceId<>0  and fldCaseId=0
					)t1
					inner join @t t on 	 t1.c=t.cod)detail
					where  detail.fldDocument_HedearId=[tblDocumentRecord_Details].fldDocument_HedearId

					and [tblDocumentRecord_Details].fldid=detail.fldid
					if (@@error<>0)
					begin
						rollback
						set @flag=1
					end
				end
			
			if(@flag=0)

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
			end
			if (@flag=0)
			begin
			SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
			UPDATE [ACC].[tblDocumentRecord_Details]
			SET     [fldCodingId] = d.fldCodingId, [fldDescription] = d.fldDescription, [fldBedehkar] = d.fldBedehkar, [fldBestankar] = d.fldBestankar, [fldCenterCoId] = d.fldCenterCoId, [fldCaseId] = d.fldCaseId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
			from  [ACC].[tblDocumentRecord_Details] inner join @Detail d on 	
			 [tblDocumentRecord_Details].fldid=d.fldid
			
				if (@@error<>0)
					rollback
			end
	end

	commit*/
GO
