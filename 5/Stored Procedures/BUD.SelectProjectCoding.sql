SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[SelectProjectCoding]
@CodingBudje_DetailsId varchar(10)

as
BEGIN TRAN
--select 0 as fldId,N'' as fldTitle,N'' fldCode,1 as fldEditable,cast(0 as bigint)[Col1],cast(0 as bigint)[Col10],cast(0 as bigint)[Col2],cast(0 as bigint)[Col3],cast(0 as bigint)[Col4]
--,cast(0 as bigint)[Col5],cast(0 as bigint)[Col6],cast(0 as bigint)[Col7],cast(0 as bigint)[Col8],cast(0 as bigint)[Col9]

DECLARE @cols AS NVARCHAR(MAX),@query  AS NVARCHAR(MAX)

--,@CodingBudje_DetailsId varchar(10)=206
select  @cols=STUFF((SELECT distinct ',' +'Col'+cast(c.fldid as varchar(2))          
  FROM bud.tblBudgetType c  
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query ='select fldId, fldTitle,fldCode,fldEditable,' + @cols + ' from (
SELECT    ACC.tblCoding_Details.fldId,  ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode,isnull(fldMablagh,0)fldMablagh,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId
						 ,isnull(fldEditable,1) as fldEditable 
FROM         ACC.tblCoding_Details  
inner join bud.tblPishbini as p on p.fldCodingAcc_DetailsId=tblCoding_Details.fldid
outer apply(select top(1) 0 as fldEditable  from acc.tblDocumentRecord_Details as d inner join acc.tblCase as c on c.fldId=d.fldCaseId
			where d.fldCodingId=tblCoding_Details.fldId and c.fldSourceId='+@CodingBudje_DetailsId+' and fldCaseTypeId=15)d
	WHERE p.fldCodingBudje_DetailsId ='+ @CodingBudje_DetailsId+ ')t
	pivot (sum(fldMablagh) for fldBudgetTypeId in (' + @cols + ')
	)p'
	--select @query

			execute(@query)
commit tran
GO
