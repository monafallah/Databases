SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_SelectCodingAccNotBudje](@fieldName nvarchar(50), @aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azsanad int,@tasanad int,@sanadtype tinyint)
as

declare @sal int=cast(SUBSTRING(@tatarikh,1,4) as int)
declare @accept1 tinyint,@accept2 tinyint

set @accept1=0
set @accept2=1
if (@sanadtype=1 or @sanadtype=0) 
begin
	set @accept1=@sanadtype
	set @accept2=@sanadtype
end
if (@azsanad = 0 or @azsanad is null) set @azsanad=1
if (@tasanad = 0 or @tasanad is null) set @tasanad=2147483647 
								
if (@fieldName='Eghtesadi')
select  c.fldId,c.fldCode,c.fldTitle from acc.tblDocumentRecord_Details d
inner join acc.tblCoding_Details c on c.fldid=d.fldCodingId
inner join acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId
inner join acc.tblDocumentRecord_Header h on h.fldid=d.fldDocument_HedearId
inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId 
cross apply (
				select top 1 t.fldid  from acc.tblTemplateCoding t2
				where t.fldTempNameId=t2.fldTempNameId and t.fldTempCodeId.IsDescendantOf(t2.fldTempCodeId)=1  and t2.fldItemId =10
)tempcod
where  h.fldType = 1 AND hp.fldDocumentNum > 0 AND h.fldFiscalYearId = @salmaliID AND h.fldOrganId =  @organid AND
    hp.fldModuleSaveId = 4 and fldTarikhDocument>=@aztarikh and fldTarikhDocument<=@tatarikh and fldDocumentNum>=@azsanad 
	and fldDocumentNum<=@tasanad
	and(@sanadtype=2 or fldAccept=@sanadtype)
	--and hp.fldAccept>=@accept1 and hp.fldAccept<=@accept2
	and not exists (select * from bud.tblBudje_khedmatDarsadId
					where fldCodingAcc_detailId=c.fldid)
group by  c.fldId,c.fldCode,c.fldTitle 



if (@fieldName='poroje')
select  c.fldId,c.fldCode,c.fldTitle from acc.tblDocumentRecord_Details d
inner join acc.tblCoding_Details c on c.fldid=d.fldCodingId
inner join acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId
inner join acc.tblDocumentRecord_Header h on h.fldid=d.fldDocument_HedearId
inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId 
left join acc.tblCase as ca on ca.fldId=d.fldCaseId and ca.fldCaseTypeId=15 
cross apply (
				select top 1 t.fldid  from acc.tblTemplateCoding t2
				where t.fldTempNameId=t2.fldTempNameId and t.fldTempCodeId.IsDescendantOf(t2.fldTempCodeId)=1  and t2.fldItemId in(11,12)
)tempcod
where h.fldType = 1 AND hp.fldDocumentNum > 0 AND h.fldFiscalYearId = @salmaliID AND h.fldOrganId =  @organid AND
    hp.fldModuleSaveId = 4 and fldTarikhDocument>=@aztarikh and fldTarikhDocument<=@tatarikh and fldDocumentNum>=@azsanad and fldDocumentNum<=@tasanad
	and(@sanadtype=2 or fldAccept=@sanadtype)
	--and hp.fldAccept>=@accept1 and hp.fldAccept<=@accept2
	and (fldCaseId is null or  
	not exists (select * from bud.tblPishbini
					where fldCodingAcc_DetailsId=c.fldid and fldCodingBudje_DetailsId=ca.fldSourceId)
					)
group by  c.fldId,c.fldCode,c.fldTitle 

GO
