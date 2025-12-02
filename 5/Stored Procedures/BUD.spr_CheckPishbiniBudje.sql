SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [BUD].[spr_CheckPishbiniBudje]
@Year smallint
as
BEGIN TRAN
--declare @Year smallint=1403
select d.fldCodeingBudjeId,d.fldTitle,d.fldCode,d.fldBudCode from bud.tblCodingBudje_Details as d
inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=d.fldHeaderId
outer apply(select top(1) c.fldCodeingBudjeId from bud.tblCodingBudje_Details as c
				inner join bud.tblPishbini as p on p.fldCodingBudje_DetailsId=c.fldCodeingBudjeId
				where c.fldHeaderId=d.fldHeaderId and c.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1)p
where h.fldYear=@Year and d.fldCode in ('1','2','3','4','5','6') and p.fldCodeingBudjeId is null


commit tran
GO
