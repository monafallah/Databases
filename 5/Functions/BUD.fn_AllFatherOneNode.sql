SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE function [BUD].[fn_AllFatherOneNode](@id int,@headerId int)
returns table
as
return(
		with w as ( select fldCode,fldhierarchyidId,@id i ,1 c from bud.[tblCodingBudje_Details] where fldCodeingBudjeId=@id
            union all
            select e.fldCode,e.fldhierarchyidId,@id i,2 c
            from bud.[tblCodingBudje_Details] e join w on(w.fldhierarchyidId.GetAncestor(1)=e.fldhierarchyidId)
			where e.fldHeaderId=@headerId )
select (select fldCode+'' from w where fldcode<>''  and c<>1 order by fldhierarchyidId  for xml path ('')) t,@id id
)
GO
