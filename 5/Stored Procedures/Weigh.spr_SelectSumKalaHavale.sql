SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectSumKalaHavale](@fieldName nvarchar(50),@Value  nvarchar(50),@idHavale int)
as
set @Value=com.fn_TextNormalize(@value)
if (@fieldName='')
select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale

if (@fieldName='fldKalaid')
select * from (select  k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale)t
where fldKalaid like @Value


if (@fieldName='fldNameKala')
select * from (select  k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale)t
where fldNameKala like @value 


if (@fieldName='fldMaxTon')
select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale and fldMaxTon like @Value

if (@fieldName='fldSumKala')
select * from (select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale) t
where fldSumKala like @Value

if (@fieldName='fldMaxTon')
select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale and fldMaxTon like @Value



if (@fieldName='fldBaghimande')
select * from (select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale )t where  fldBaghimande like @Value



if (@fieldName='fldNameHeader')
select * from (select k.fldid fldKalaid,fldName as fldNameKala ,fldMaxTon,cast(sumVazn as float) as fldSumKala,fldMaxTon-(cast(sumVazn as float)) as fldBaghimande 
,h.fldTitle as fldNameHeader
from Weigh.tblRemittance_Details d
inner join Weigh.tblRemittance_Header h on fldRemittanceId=h.fldid
inner join com.tblKala k on k.fldId=fldKalaId
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn
where fldRemittanceId=@idHavale )t 
where  fldNameHeader like @Value

GO
