SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [ACC].[fn_GetCaseTypeId](@ModuleErsalId int,@Document_HedearId int)
returns  int
begin
declare @CaseTypeId int,@id int

if(@ModuleErsalId=13)
	select @CaseTypeId=c.fldCaseTypeId from acc.tblDocumentRecord_Details as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId 
		inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
		where d.fldDocument_HedearId=@Document_HedearId  and fldItemId=20
else if(@ModuleErsalId=12)
	select @CaseTypeId=c.fldCaseTypeId from acc.tblDocumentRecord_Details as d 
		inner join acc.tblCase as c on c.fldId=d.fldCaseId 
		inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
		where d.fldDocument_HedearId=@Document_HedearId  and fldItemId in(38,46)
	return @CaseTypeId
end
GO
