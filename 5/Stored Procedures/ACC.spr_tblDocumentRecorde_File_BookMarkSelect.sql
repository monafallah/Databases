SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_tblDocumentRecorde_File_BookMarkSelect] 
 @FieldName varchar(50),
 @fldDocumentHeaderId int,
 @fldArchiveTreeId int
  as
 begin tran
	declare @Document_HedearId int=0
			
	select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
	where fldId=@fldDocumentHeaderId

	 if(@FieldName='')
		with c as (
		select a.fldTitle,a.fldId,a.fldPID,b.fldId as bookid,fldArchiveTreeId from acc.tblDocumentBookMark as b
		inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
		inner join Arch.tblArchiveTree as a on a.fldId=b.fldArchiveTreeId
		where f.fldDocumentHeaderId =@Document_HedearId
		union all
		select a.fldTitle,a.fldId,a.fldPID,c.bookid,fldArchiveTreeId from Arch.tblArchiveTree as a 
		inner join c on c.fldPID=a.fldId
		) , book as
		(
		select distinct bookid,fldArchiveTreeId,stuff((select '-'+fldTitle from c as c2 where c2.bookid=c.bookid order by fldid for xml path('')),1,1,'') as fldTitle
		from c
		)
		select df.fldId,f.fldImage,f.fldPasvand,isnull(b.fldArchiveTreeId,0) as fldArchiveTreeId,case when b.fldId is null then cast(0 as bit) else cast(1 as bit) end fldIsBookMark
		,isnull(fldTitle,'') as fldTitle
			from acc.tblDocumentRecorde_File as df
			inner join com.tblFile as f on f.fldId=df.fldFileId
			left join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=df.fldId
			left join book on book.bookid=b.fldId
			where df.fldDocumentHeaderId=@Document_HedearId

	if(@FieldName='IsNotBookMark')
		select df.fldId,f.fldImage,f.fldPasvand,isnull(b.fldArchiveTreeId,0) as fldArchiveTreeId,cast(0 as bit) fldIsBookMark ,N'' as fldTitle
		from acc.tblDocumentRecorde_File as df
		inner join com.tblFile as f on f.fldId=df.fldFileId
		left join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=df.fldId
		where df.fldDocumentHeaderId=@Document_HedearId
		and b.fldId is null

	if(@FieldName='IsBookMark')
		with c as (
		select a.fldTitle,a.fldId,a.fldPID,b.fldId as bookid,fldArchiveTreeId from acc.tblDocumentBookMark as b
		inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
		inner join Arch.tblArchiveTree as a on a.fldId=b.fldArchiveTreeId
		where f.fldDocumentHeaderId =@Document_HedearId
		union all
		select a.fldTitle,a.fldId,a.fldPID,c.bookid,fldArchiveTreeId from Arch.tblArchiveTree as a 
		inner join c on c.fldPID=a.fldId
		) , book as
		(
		select distinct bookid,fldArchiveTreeId,stuff((select '-'+fldTitle from c as c2 where c2.bookid=c.bookid order by fldid for xml path('')),1,1,'') as fldTitle
		from c
		)
		select df.fldId,f.fldImage,f.fldPasvand,isnull(b.fldArchiveTreeId,0) as fldArchiveTreeId,case when b.fldId is null then cast(0 as bit) else cast(1 as bit) end fldIsBookMark
		,isnull(fldTitle,'') as fldTitle
			from acc.tblDocumentRecorde_File as df
			inner join com.tblFile as f on f.fldId=df.fldFileId
			left join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=df.fldId
			left join book on book.bookid=b.fldId
			where df.fldDocumentHeaderId=@Document_HedearId
			and b.fldId is not null
	if(@FieldName='fldArchiveTreeId')
		with c as(
			select fldId,fldPID,fldTitle from Arch.tblArchiveTree as a
			where a.fldId=@fldArchiveTreeId
			union all
			select a.fldId,a.fldPID,a.fldTitle  from Arch.tblArchiveTree as a 
			inner join c on c.fldID=a.fldPID
			)
			, b as (
				select a.fldTitle,a.fldId,a.fldPID,b.fldId as bookid,b.fldArchiveTreeId from acc.tblDocumentBookMark as b
					inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
					inner join c as a on a.fldId=b.fldArchiveTreeId
					where f.fldDocumentHeaderId=@Document_HedearId
						)
			,p as (select c.fldId,c.fldPID,c.fldTitle,b.fldId as bookid from c
					inner join acc.tblDocumentBookMark as b  on c.fldId=b.fldArchiveTreeId
					inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
					where f.fldDocumentHeaderId=@Document_HedearId
					union all
					select a.fldId,a.fldPID,a.fldTitle,p.bookid from Arch.tblArchiveTree as a
					inner join p on p.fldPID=a.fldId
					) 
			,p2 as (select distinct * from p)
			, book as
					(
					select distinct p2.fldID,bookid,stuff((select '-'+fldTitle from p2 as c2 where c2.bookid=p2.bookid order by fldid for xml path('')),1,1,'') as fldTitle
					from p2
					)
					select df.fldId,f.fldImage,f.fldPasvand,isnull(b.fldArchiveTreeId,0) as fldArchiveTreeId,case when b.fldId is null then cast(0 as bit) else cast(1 as bit) end fldIsBookMark
					,isnull(fldTitle,'') as fldTitle
						from acc.tblDocumentRecorde_File as df
						inner join com.tblFile as f on f.fldId=df.fldFileId
						inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=df.fldId
						inner join book on book.bookid=b.fldId and book.fldId=b.fldArchiveTreeId
						where df.fldDocumentHeaderId=@Document_HedearId 
						OPTION(MAXRECURSION 0)	
commit tran
GO
