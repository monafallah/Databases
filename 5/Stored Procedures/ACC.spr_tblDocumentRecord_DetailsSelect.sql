SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_DetailsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	DECLARE @Document_HedearId int=0
	if (@fieldname=N'fldId')
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName
			,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] 
			inner join acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId  
			WHERE  tblDocumentRecord_Details.fldId like @Value 
			
			order by fldorder

	if (@fieldname=N'fldDocument_HedearId')
	begin
		if(@Value=0)
		begin
			declare @temp table([fldId] int NOT NULL,[fldDocument_HedearId] int NOT NULL,[fldCodingId] int NOT NULL,[fldDescription] nvarchar(max) NOT NULL,
			[fldBedehkar] bigint NOT NULL,	[fldBestankar] bigint NOT NULL,	[fldCenterCoId] int NOT NULL,	[fldCaseId] int NOT NULL,	[fldDesc] nvarchar(max) NOT NULL,
			[fldDate] [datetime] NOT NULL,[fldIP] [varchar](16) NOT NULL,	[fldUserId] int NOT NULL,fldSourceId int  NOT NULL,fldCaseTypeId int NOT NULL
			,fldName nvarchar(200) NOT NULL,fldNameCenter nvarchar(200) NULL,fldOrder smallint, fldCode varchar(100), fldNameCoding nvarchar(100), fldName_CodeDetail  nvarchar(200),fldBud_ProjectId int NULL)
			insert @temp
			values(0,0,0,'',0,0,0,0,'',GETDATE(),'',0,0,0,'','',0,'','','',0)
			select * from @temp
		end
		else
		begin
			select @Document_HedearId=fldDocument_HedearId from acc.tblDocumentRecord_Header1
			where fldId=@Value
			SELECT top(@h) tblDocumentRecord_Details.[fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName
			,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] 
			inner join acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE   fldDocument_HedearId=@Document_HedearId 
			and (fldDocument_HedearId1=@value
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@value ) and fldDocument_HedearId1 is null )) 
			
			
			order by fldOrder		end
	end
	
	

	
	if (@fieldname=N'fldCodingId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId,''as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId  inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE  tblDocumentRecord_Details.fldCodingId like @Value 
			
	if (@fieldname=N'fldCenterCoId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,tblCase.fldSourceId,fldCaseTypeId,'' as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE  tblDocumentRecord_Details.fldCenterCoId like @Value

	if (@fieldname=N'fldCaseId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId,''as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE  tblDocumentRecord_Details.fldCaseId like @Value 

	if (@fieldname=N'FishId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [tblDocumentRecord_Details].[fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId,''as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			INNER JOIN acc.tblDocumentRecord_Header h on h.fldid=[tblDocumentRecord_Details].fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 h1 on h1.fldDocument_HedearId=h.fldid
			WHERE  fldCaseTypeId=6 and fldSourceId=@Value and fldModuleErsalId=5
			and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 

	if (@fieldname=N'CheckId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [tblDocumentRecord_Details].[fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId,''as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			INNER JOIN acc.tblDocumentRecord_Header h on h.fldid=[tblDocumentRecord_Details].fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 h1 on h1.fldDocument_HedearId=h.fldid
			WHERE  fldCaseTypeId=3 and fldSourceId=@Value and fldModuleErsalId=12
			and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 

	if (@fieldname=N'CheckSadereId')/*برای چک کردن */
	SELECT top(@h) tblDocumentRecord_Details.[fldId], [tblDocumentRecord_Details].[fldDocument_HedearId], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], tblDocumentRecord_Details.[fldDesc], tblDocumentRecord_Details.[fldDate], tblDocumentRecord_Details.[fldIP], tblDocumentRecord_Details.[fldUserId] 
			,isnull(tblCase.fldSourceId,0) as fldSourceId,isnull(tblCase.fldCaseTypeId,0) as fldCaseTypeId,''as fldName,tblCenterCost.fldNameCenter,fldOrder
			,c.fldCode,c.fldTitle as fldNameCoding,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail
			FROM   [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			INNER JOIN acc.tblDocumentRecord_Header h on h.fldid=[tblDocumentRecord_Details].fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 h1 on h1.fldDocument_HedearId=h.fldid
			WHERE  fldCaseTypeId=4 and fldSourceId=@Value and fldModuleErsalId=12
			and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 

	COMMIT
GO
