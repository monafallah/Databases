SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Weigh].[spr_SelectBaskoolParametr_Value](@baskoolId int)
as
--declare @baskoolId int
select tblParametrsBaskool.fldid,fldFaName,fldEnName,isnull(param_value.fldid,0)fldParam_ValueId,
isnull(fldValue,'')fldValue
from Weigh.tblParametrsBaskool
outer apply (select v.fldid,v.fldValue from Weigh.tblParametrBaskoolValue v
where fldParametrBaskoolId=tblParametrsBaskool.fldid and fldBaskoolId=@baskoolId)param_value
GO
