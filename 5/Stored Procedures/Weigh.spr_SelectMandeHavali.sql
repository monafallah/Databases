SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectMandeHavali]
@IdHavale int,
@IdBaskool int,
@IdKala int

as 
select fldCountHavale,fldMaxTon-isnull(SumVazn,0) as fldBaghimande from (
			select isnull(count(fldid),0)as fldCountHavale ,isnull(sum(fldVaznKhals) ,0)SumVazn
			from [Weigh].[tblVazn_Baskool]
			where fldBaskoolId=@IdBaskool and fldKalaId=@IdKala and fldRemittanceId=@IdHavale
			and fldEbtal=0
 )v
outer apply (
				select fldMaxTon from tblRemittance_Details
				where fldRemittanceId=@IdHavale and fldKalaId=@IdKala
			)MaxRemittance



GO
