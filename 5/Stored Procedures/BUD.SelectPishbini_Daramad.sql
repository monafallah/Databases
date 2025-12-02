SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [BUD].[SelectPishbini_Daramad]
 @Year VARCHAR(4)
as
--declare @Year VARCHAR(4)=1402
--select N''[کدینگ],N''[عنوان],cast(0 as bigint)[افزایش],cast(0 as bigint)[عملکرد 9 ماهه آخر سال قبل],cast(0 as bigint)[عملکرد دو سال قبل],cast(0 as bigint)[عملکرد سه ماهه آخر دو سال قبل],cast(0 as bigint)[عملکرد]
--,cast(0 as bigint)[مبلغ پیشنهادی],cast(0 as bigint)[مصوب سال قبل],cast(0 as bigint)[مصوب],cast(0 as bigint)[نرخ رشد پنج ساله],cast(0 as bigint)[کاهش],1 last
DECLARE @cols AS NVARCHAR(MAX),@Coding NVARCHAR(50)=N'کدینگ',@Title NVARCHAR(50)=N'عنوان',@Mablagh NVARCHAR(50)=N'مبلغ پیشنهادی',
    @query  AS NVARCHAR(MAX);

SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(case when fldId=1 then N'مبلغ پیشنهادی' else  c.fldTitle end) 
            FROM bud.tblBudgetType c
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')
set @query='
select fldCode as '+@Coding+',fldTitle as '+@Title+',' + @cols + ',last from (
select d.fldId,d.fldCode,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh
,case when b.fldId=1 then N'''+@Mablagh+''' else  b.fldTitle end as fldTitleBudge 
,isnull(last,0)last
from acc.tblCoding_Header as h 
inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId
inner join acc.tblTemplateCoding as t on t.fldItemId=7
left join bud.tblPishbini as p 
inner join bud.tblBudgetType as b on b.fldId=p.fldBudgetTypeId
on p.fldCodingAcc_DetailsId=d.fldId
outer apply (select 1 last from  acc.tblCoding_Details d1 
left join  acc.tblCoding_Details p1 on  p1.fldCodeId.GetAncestor(1)=d1.fldCodeId
where d1.fldHeaderCodId=h.fldid and p1.fldid is null and d1.fldid=d.fldid)lastnod

where h.fldYear='+@Year+' and c.fldTempCodeId.IsDescendantOf(t.fldTempCodeId)=1)
x
            pivot 
            (
                 sum(fldMablagh)
                for fldTitleBudge in (' + @cols + ')
            ) p '
--select @query

execute(@query)
GO
