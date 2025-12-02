SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectMoratabSaziTarikhSanad]
@OrganId int,
@Year smallint,
@ModuleId int,
@UserId int

as 
begin tran
if(@ModuleId=4)
	begin
		--declare @fldOrganId int=1,@Year smallint=1401,@ModuleId int=4
		update tblDocumentRecord_Header1
		set fldDocumentNum=case when fldTypeSanadId=1 then 1 else  t.Shomare end ,fldUserId=@UserId
		from  acc.tblDocumentRecord_Header1 
		cross apply
				 (select 1+row_Number()over(order by h1.fldtypesanadId, h1.fldTarikhDocument,h1.fldDate)Shomare
				 ,h1.fldid --,fldTypeSanadId
					from acc.tblDocumentRecord_Header as h
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					inner join acc.tblFiscalYear f on f.fldid =fldFiscalYearId
					where h.fldorganId=@OrganId and f.fldYear=@Year and h1.fldModuleSaveId=@ModuleId
					and h1.fldDocumentNum<>0 and h1.fldTypeSanadId<>1/*سند افتتاحیه همیشه شماره سندش 1 میباشد*/
					)t
		where tblDocumentRecord_Header1.fldid=t.fldid
		 if (@@error<>0)
			rollback
	end
else
	begin
		update tblDocumentRecord_Header1
		set fldDocumentNum=t.Shomare ,fldUserId=@UserId
		from  acc.tblDocumentRecord_Header1 
		cross apply
				 (select row_Number()over(order by h1.fldtypesanadId, h1.fldTarikhDocument,h1.fldDate)Shomare
				 ,h1.fldid --,fldTypeSanadId
					from acc.tblDocumentRecord_Header as h
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					inner join acc.tblFiscalYear f on f.fldid =fldFiscalYearId
					where h.fldorganId=@OrganId and f.fldYear=@Year and h1.fldModuleSaveId=@ModuleId
					and h1.fldDocumentNum<>0
					)t
		where tblDocumentRecord_Header1.fldid=t.fldid
		 if (@@error<>0)
			rollback
	end
commit
GO
