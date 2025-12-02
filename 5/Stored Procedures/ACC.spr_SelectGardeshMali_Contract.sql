SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectGardeshMali_Contract]
@OrganId int
as
begin tran
select abs(fldMande)fldMande,fldCode,fldNameCoding,case when fldMande<0 then N'بستانکار' when fldMande>0 then N'بدهکار' else N'خنثی' end fldTypeMande
from (
SELECT  sum([fldBedehkar])-sum( [fldBestankar]	) as fldMande
			,c.fldCode,c.fldTitle as fldNameCoding
			FROM   [ACC].[tblDocumentRecord_Details] 
			inner join acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId inner join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join
			acc.tblCoding_Details c on c.fldid=fldCodingId 
			WHERE  fldCaseTypeId  in (13,14) and fldOrganId=@OrganId
			group by  c.fldCode,c.fldTitle)t
commit tran
GO
