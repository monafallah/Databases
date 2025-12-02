SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [ACC].[fn_GetArtiklMap]( @Document_HedearId int, @Document_HedearId1 int,@ModuleErsalId int)
returns tinyint
begin
	declare @fldIsMap tinyint=0,@ItemId int=0--,@Document_HedearId int= 59, @Document_HedearId1 int=131
	if(@ModuleErsalId=5)
		set @ItemId=14
	else if(@ModuleErsalId=12)
		set @ItemId=38

	select top(1) @fldIsMap=1 
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblCase as c on c.fldId=d.fldCaseId			
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.[tblArtiklMap] as a on a.fldType=c.fldCaseTypeId
			cross apply(select * from com.Split(a.fldSourceId,','))s 
			WHERE    c.fldSourceId=s.Item and s.Item<>''  and fldItemId=@ItemId and 
			fldDocument_HedearId=@Document_HedearId
			and (fldDocument_HedearId1=@Document_HedearId1
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@Document_HedearId1 ) and fldDocument_HedearId1 is null ))
if(@fldIsMap is null)
	set @fldIsMap=0
	return @fldIsMap

end
GO
