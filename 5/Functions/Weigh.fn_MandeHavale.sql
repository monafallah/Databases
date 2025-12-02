SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Weigh].[fn_MandeHavale](@IdKala int,@IdHavale int)
returns table
as
return
(select cast(isnull(fldMaxTon,0)-isnull(SumVazn,0) as bigint) as fldBaghimande,fldRemittanceId Idhavale from (
			select isnull(count(fldid),0)as fldCountHavale ,isnull(sum(cast(fldVaznKhals as bigint)) ,cast(0 as bigint))SumVazn
			from [Weigh].[tblVazn_Baskool]
			where /*fldKalaId=@IdKala and*/ fldRemittanceId=@IdHavale
			and fldEbtal=0
 )v
outer apply (
				select sum(cast(fldMaxTon as bigint) )fldMaxTon,fldRemittanceId from Weigh. tblRemittance_Details
				where fldRemittanceId=@IdHavale --and fldKalaId=@IdKala
				group by fldRemittanceId
			)MaxRemittance
)
			
GO
