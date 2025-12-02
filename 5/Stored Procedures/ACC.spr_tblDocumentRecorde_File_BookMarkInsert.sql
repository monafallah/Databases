SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecorde_File_BookMarkInsert] 
   
    @fldDocumentHeaderId int,
	@fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
	@fldIP varchar(16),
	@tblRecorde_File as Acc.tblRecorde_File readonly,
	@fldDocumentRecordeId_Del varchar(max)
AS 

	
	--begin try
		BEGIN TRAN 
		
	--	declare  @fldDocumentHeaderId int=6,
	--@fldOrganId int=1,
 --   @fldUserId int=1,
 --   @fldDesc nvarchar(100)='',
	--@fldIP varchar(16)='1',
	--@tblRecorde_File as Acc.tblRecorde_File 

	
	--insert @tblRecorde_File
	--select top 1 31,0,fldImage,1,fldPasvand from com.tblFile
	--where fldImage is not null and fldId not in  (8485,8486)
	--order by fldid desc

	--insert @tblRecorde_File
	--select  31,df.fldId,fldImage,case when df.fldId in (6) then 0 else 1 end,fldPasvand 
	--from acc.tblDocumentRecorde_File as df
	--inner join com.tblFile as f on f.fldId=df.fldFileId
	----where df.fldId<>6
	

			declare @t table(id int identity ,fldId int,fldFileId int,fldImage varbinary(MAX),fldPasvand VARCHAR(5),fldArchiveTreeId int,fldRecorde_FileId int,fldIsBookMark bit)
			
			declare @Document_HedearId int=0
			
			select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
	where fldId=@fldDocumentHeaderId

			insert @t(fldId ,fldImage ,fldPasvand ,fldArchiveTreeId  ,fldIsBookMark )
			select fldId,fldImage,fldPasvand,fldArchiveTreeId,fldIsBookMark from @tblRecorde_File 

			update @t set fldArchiveTreeId=null
			where fldArchiveTreeId=0

			update t set t.fldFileId=df.fldFileId from @t  as t
			inner join  acc.tblDocumentRecorde_File as df on t.fldId=df.fldId
	
	 
			set @fldDesc=com.fn_TextNormalize(@fldDesc)
			declare @fldID int ,@fileId int,@fldRecorde_FileId int

			select @fileId =ISNULL(max(fldId),0) from [Com].[tblFile] 
			INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
			SELECT row_number() over (order by id) +@fileId, fldImage,fldPasvand, @fldUserId, @fldDesc, GETDATE()
			from @t as t
			where t.fldId=0
			if (@@error<>0)
		rollback
	else
	begin
			update t2 set fldFileId=t.fileId
			 from @t as t2 inner join (SELECT row_number() over (order by t.id) +@fileId as fileId,t.id, t.fldImage,t.fldPasvand
			from @t as t where t.fldId=0)t on t2.id=t.id 
			where t2.fldId=0
	
			select @fldRecorde_FileId =ISNULL(max(fldId),0) from [ACC].[tblDocumentRecorde_File] 

			INSERT INTO [ACC].[tblDocumentRecorde_File] ([fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate],fldIP)
				SELECT row_number() over (order by id) +@fldRecorde_FileId, @Document_HedearId, t.fldFileId, @fldUserId, @fldDesc, getdate(),@fldIP
					from @t as t
				where t.fldId=0
if (@@error<>0)
		rollback
	else
	begin
			update t2 set fldRecorde_FileId=t.recId
				from @t as t2 inner join (SELECT row_number() over (order by t.id) +@fldRecorde_FileId as recId,t.id, t.fldImage,t.fldPasvand
			from @t as t where t.fldId=0)t on t2.id=t.id 
			where t2.fldId=0
	
		update t set fldRecorde_FileId=t.fldId
				from @t  as t
				where fldRecorde_FileId is null

				select * from @t
			declare @fldBookMArkID int 
			select @fldBookMArkID =ISNULL(max(fldId),0) from [ACC].[tblDocumentBookMark] 

			INSERT INTO [ACC].[tblDocumentBookMark] ([fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
			SELECT row_number() over (order by id) +@fldBookMArkID, fldRecorde_FileId, t.fldArchiveTreeId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
			from @t as t
			left  join [ACC].[tblDocumentBookMark]  as b on b.fldDocumentRecordeId=t.fldId
			where b.fldId is null and t.fldIsBookMark=1
			if (@@error<>0)
		rollback
	else
	begin
			delete  b from [ACC].[tblDocumentBookMark] as b
			left join @t as b2 on b2.fldRecorde_FileId =b.fldDocumentRecordeId
			where b2.fldIsBookMark=0
			or b.fldDocumentRecordeId in (select Item from com.Split(@fldDocumentRecordeId_Del,','))
			if (@@error<>0)
		rollback
	else
	begin
		
			declare @file varchar(max)=''

			select @file=@file+cast(b.fldFileId as varchar(10))+',' from [ACC].[tblDocumentRecorde_File] as b
			where  b.fldId in (select Item from com.Split(@fldDocumentRecordeId_Del,','))

			delete  b from [ACC].[tblDocumentRecorde_File] as b
			where b.fldId in (select Item from com.Split(@fldDocumentRecordeId_Del,','))
			if (@@error<>0)
		rollback
	else
	begin
			delete com.tblFile
			where fldId in (select Item from com.Split(@file,','))
			if (@@error<>0)
		rollback
			 --select 0 as ErrorCode,N'' as ErrorMessage
						end
					end
				end
			 end
		end	
		COMMIT TRAN
	--end try
	--begin catch
	--	rollback
	--	--select @@ERROR as ErrorCode,ERROR_MESSAGE() as ErrorMessage
	
	--end catch
GO
