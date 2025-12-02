SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [chk].[spr_SelectSumCheckSadere] 
	@fieldname nvarchar(50),
	@Value  nvarchar(50)
as
begin tran

if (@fieldname='fldTankhahGroupId')
select sum(cast(fldMablagh as bigint)) fldMablagh from chk.tblSodorCheck s
inner join [chk].[tblCheck_Factor] ch on ch.fldCheckSadereId=s.fldid
WHERE  fldTankhahGroupId=@value

if (@fieldname='fldFactorId')
select sum(cast(fldMablagh as bigint)) fldMablagh from chk.tblSodorCheck s
inner join [chk].[tblCheck_Factor] ch on ch.fldCheckSadereId=s.fldid
WHERE  fldFactorId=@value

if (@fieldname='fldContractId')
select sum(cast(fldMablagh as bigint)) fldMablagh from chk.tblSodorCheck s
inner join [chk].[tblCheck_Factor] ch on ch.fldCheckSadereId=s.fldid
WHERE  fldContractId=1

commit
GO
