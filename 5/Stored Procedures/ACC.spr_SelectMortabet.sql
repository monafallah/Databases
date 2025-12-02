SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [ACC].[spr_SelectMortabet] 
@DocumentRecord_Header1 int,
@ModuleSaveId int
as
begin tran
		declare @Source varchar(max)='',@ItemId int,@CaseTypeId tinyint=0

		select @ItemId=fldItemId
					FROM   [ACC].[tblDocumentRecord_Details] as d		
					inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
					inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
					inner join acc.tblDocumentRecord_Header as h2 on h2.fldId=d.fldDocument_HedearId			
					inner join acc.tblDocumentRecord_Header1 as h21 on h2.fldId=h21.fldDocument_HedearId
					WHERE  h21.fldId = @DocumentRecord_Header1  and fldModuleSaveId=@ModuleSaveId
					and (fldDocument_HedearId1=h21.fldId
					 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h21.fldId ) 
					 and fldDocument_HedearId1 is null ))

		if @ItemId=14 
			set @CaseTypeId=6 
		else if @ItemId=38
			set @CaseTypeId=3
	
		select @Source=@Source+a.fldSourceId+N','
					FROM   [ACC].[tblDocumentRecord_Details] as d
					inner join acc.tblCase as c on c.fldId=d.fldCaseId			
					inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
					inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
					inner join acc.[tblArtiklMap] as a on a.fldType=c.fldCaseTypeId
					inner join acc.tblDocumentRecord_Header as h2 on h2.fldId=d.fldDocument_HedearId			
					inner join acc.tblDocumentRecord_Header1 as h21 on h2.fldId=h21.fldDocument_HedearId
					cross apply(select * from com.Split(a.fldSourceId,','))s 
					WHERE  h21.fldId = @DocumentRecord_Header1 
				 and  c.fldSourceId=s.Item and s.Item<>''  AND fldItemId=@ItemId 
					and fldCaseTypeId=@CaseTypeId and fldModuleSaveId=@ModuleSaveId
					and (fldDocument_HedearId1=h21.fldId
					 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h21.fldId ) 
					 and fldDocument_HedearId1 is null ))

		
		select distinct h1.fldId from [ACC].[tblDocumentRecord_Details] as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId	
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId			
			inner join acc.tblDocumentRecord_Header1 as h1 on h.fldId=h1.fldDocument_HedearId
			where  fldItemId=@ItemId and fldCaseTypeId=@CaseTypeId  and c.fldSourceId in (select value from string_split(@Source,',') where value<>'') 
			 and fldModuleSaveId=@ModuleSaveId
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null ))
commit tran	
GO
