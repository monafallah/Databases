SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [ACC].[fn_GetSourceId](@ModuleErsalId int,@Document_HedearId int)
returns  int
begin
declare @SourceId int
if(@ModuleErsalId=5)
	select @SourceId=c.fldSourceId from acc.tblDocumentRecord_Details as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId 
		inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
		where d.fldDocument_HedearId=@Document_HedearId and fldCaseTypeId=6 and fldItemId=14

else if(@ModuleErsalId=12)
	select @SourceId=c.fldSourceId from acc.tblDocumentRecord_Details as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId 
		inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
		where d.fldDocument_HedearId=@Document_HedearId and ((fldCaseTypeId=3 and fldItemId=38) or (fldCaseTypeId=4 and fldItemId=46))
else if(@ModuleErsalId=13)
	select @SourceId=c.fldSourceId from acc.tblDocumentRecord_Details as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId 
		inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
		where d.fldDocument_HedearId=@Document_HedearId  and fldItemId=20
	return @SourceId
end
GO
