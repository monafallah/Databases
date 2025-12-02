SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_CheckRemain]

 @Coding_DetailsId int =102,@fldId int=0,@Bedehkar bigint=1000,@Bestankar bigint=0,@Year smallint,@OrganId int,@ModuleSaveId int

 as
 begin tran
	declare @type int ,@Mahiyat int

	
	select @type=case when (fldBedehkar+@Bedehkar)>(fldBestankar+@Bestankar) then 1 when (fldBedehkar+@Bedehkar)<(fldBestankar+@Bestankar) then 2 else 3 end  
	from (
	select sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar 
	from acc.tblDocumentRecord_Details as d 
	inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and
	d.fldCodingId=@Coding_DetailsId and h1.fldDocumentNum<>0 
	and (@fldId=0 or @fldId<>d.fldId)
	)t

 	select case when @type=@Mahiyat or @Mahiyat is null then cast(1 as bit) else cast(0 as bit) end as fldCheck
 commit tran
GO
