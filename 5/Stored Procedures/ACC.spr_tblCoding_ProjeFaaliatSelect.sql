SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_ProjeFaaliatSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	select pf.[fldCodeingBudjeId] as fldId,c.fldId as  [fldCodingDetailId] ,c.fldTitle as fldCodingTitle,c.fldMahiyatId,c.fldCode as fldCodeAcc
	from bud.tblPishbini as i
	inner join acc.tblCoding_Details p on p.fldid=i.fldCodingAcc_DetailsId
	inner join  bud.tblCodingBudje_Details pf on pf.fldCodeingBudjeId=i.fldCodingBudje_DetailsId
	inner join acc.tblCoding_Details as c on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1
	inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
	inner join  bud.tblCodingBudje_Header as bh on bh.fldHedaerId=pf.fldHeaderId and bh.fldOrganId=h.fldOrganId and bh.fldYear=h.fldYear
	left join acc.tblCoding_Details as ch on ch.fldCodeId.GetAncestor(1)=c.fldCodeId
	where  pf.fldCodeingBudjeId=@Value and ch.fldId is null 
	group by pf.[fldCodeingBudjeId] ,c.fldId,c.fldTitle,c.fldMahiyatId,c.fldCode



	if (@FieldName='fldCodingDetailId')
	select pf.[fldCodeingBudjeId] as fldId,c.fldId as  [fldCodingDetailId] ,c.fldTitle as fldCodingTitle,c.fldMahiyatId,c.fldCode as fldCodeAcc
	from bud.tblPishbini as i
	inner join acc.tblCoding_Details p on p.fldid=i.fldCodingAcc_DetailsId
	inner join  bud.tblCodingBudje_Details pf on pf.fldCodeingBudjeId=i.fldCodingBudje_DetailsId
	inner join acc.tblCoding_Details as c on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1
	inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
	inner join  bud.tblCodingBudje_Header as bh on bh.fldHedaerId=pf.fldHeaderId and bh.fldOrganId=h.fldOrganId and bh.fldYear=h.fldYear
	left join acc.tblCoding_Details as ch on ch.fldCodeId.GetAncestor(1)=c.fldCodeId
	where   ch.fldId is null and c.fldId = @Value
	group by pf.[fldCodeingBudjeId] ,c.fldId,c.fldTitle,c.fldMahiyatId,c.fldCode


	
	if (@FieldName='')
	select pf.[fldCodeingBudjeId] as fldId,c.fldId as  [fldCodingDetailId] ,c.fldTitle as fldCodingTitle,c.fldMahiyatId,c.fldCode as fldCodeAcc
	from bud.tblPishbini as i
	inner join acc.tblCoding_Details p on p.fldid=i.fldCodingAcc_DetailsId
	inner join  bud.tblCodingBudje_Details pf on pf.fldCodeingBudjeId=i.fldCodingBudje_DetailsId
	inner join acc.tblCoding_Details as c on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1
	inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
	inner join  bud.tblCodingBudje_Header as bh on bh.fldHedaerId=pf.fldHeaderId and bh.fldOrganId=h.fldOrganId and bh.fldYear=h.fldYear
	left join acc.tblCoding_Details as ch on ch.fldCodeId.GetAncestor(1)=c.fldCodeId
	where   ch.fldId is null and c.fldId like @Value
	group by pf.[fldCodeingBudjeId] ,c.fldId,c.fldTitle,c.fldMahiyatId,c.fldCode

	
	COMMIT

GO
