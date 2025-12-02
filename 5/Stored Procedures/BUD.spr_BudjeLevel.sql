SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_BudjeLevel](@year smallint ,@organId int)
as
begin tran

declare @temp TABLE(fldId int,fldOrganId INT,fldYear SMALLINT,fldArghamNum int,fldName nvarchar(100))

insert into @temp
select tblCodingLevel.fldid,tblCodingLevel.fldOrganId,fldYear ,fldArghamNum, fldName
from bud.tblCodingLevel inner join Acc.tblFiscalYear f
on f.fldid=fldFiscalBudjeId
	where fldYear=@year and tblCodingLevel.fldOrganId=@organId

if exists (select * from @temp)

select * from @temp


else
begin
	insert @temp
	values(0,@organId,@year,1,N'مأموریت'),(0,@organId,@year,1,N'برنامه'),(0,@organId,@year,1,N'طرح/خدمت'),(0,@organId,@year,1,N'پروژه/فعالیت')

	select * FROM @temp
end
commit
GO
