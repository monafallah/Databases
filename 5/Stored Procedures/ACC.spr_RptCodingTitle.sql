SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptCodingTitle]
 @Coding_DetailsId int ,@Level1 int,@Level2 int,@OrganId int,@Year smallint
 as
 begin tran
 --declare @Coding_DetailsId int =0,@Level1 int=1,@Level2 int=6,@OrganId int=1,@Year smallint=1402
 ;with lev as (
  select fldName,ROW_NUMBER() over (order by fldid) LevelId from Acc.tblAccountingLevel
 where fldOrganId=@OrganId and fldYear=@Year
 )
	select case when @Coding_DetailsId=0 then N'کل کدینگ' else  p.fldTitle+N' ('+p.fldCode+')' end as fldTitle
	,isnull(a1.fldLevelName1,'')fldLevelName1
	,isnull(a2.fldLevelName2,'')fldLevelName2
	from Acc.tblCoding_Details as p
	outer apply(select fldName as fldLevelName1 from lev as a	where a.LevelId=@Level1)a1
	outer apply(select fldName as fldLevelName2 from lev as a	where a.LevelId=@Level2)a2
	where   p.fldId=@Coding_DetailsId

 commit tran

GO
