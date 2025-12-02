SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_CheckMahiyatGardesh_Mande] ( @organid int,@year smallint,@Bed bigint,@Best bigint,@IdDetail int,@ModuleSaveId int,@fldid int)
as 
begin tran 
--declare @organid int=1,@year smallint=1402,@Bed bigint=236,@Best bigint=0,@IdDetail int=626,@ModuleSaveId int=4
--if (@Bed<>0)
select fldBedehkar,fldBestankar,fldMahiyat_GardeshId,fldMahiyatId,	
case when fldNoe_Mande  <>fldMahiyatId then 1 else 0 end fldMahiyatMonde
,case when fldNoe_Mande <> fldMahiyat_GardeshId  then 1 else 0 end fldMahiyatGardesh
 from (
select fldBedehkar,fldBestankar, case when fldBedehkar>fldBestankar then 1 when fldBedehkar<fldBestankar then 2 else 3 end as fldNoe_Mande,fldMahiyatId,fldMahiyat_GardeshId from 
(
select sum(fldBedehkar)+@Bed fldBedehkar,sum(fldBestankar)+@Best fldBestankar,fldMahiyat_GardeshId,fldMahiyatId from
acc.tblCoding_Details  as c 
inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
where fldCodingId=@IdDetail and (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum<>0 
			and (@fldid=0 or @fldid<>c.fldid)
			group by fldMahiyat_GardeshId,fldMahiyatId
	)t
)r
COMMIT
--else if (@Best<>0)
--select fldBedehkar,fldBestankar,fldMahiyatId,fldMahiyat_GardeshId,fldMahiyatId,	case when (fldNoe_Mande =1 and fldMahiyatId=2 ) or (fldNoe_Mande=2 and fldMahiyatId=1) then 1 else 0 end fldMahiyatMonde
--,	case when (fldNoe_Mande =1 and fldMahiyat_GardeshId=2 ) or (fldNoe_Mande=2 and fldMahiyat_GardeshId=1) then 1 else 0 end fldMahiyatGardesh
-- from (
--select fldBedehkar,fldBestankar ,case when fldBedehkar>fldBestankar then 1 when fldBedehkar<fldBestankar then 2 else 3 end as fldNoe_Mande,fldMahiyatId,fldMahiyat_GardeshId from 
--(
--select sum(fldBedehkar) fldBedehkar,sum(fldBestankar)+@Best fldBestankar,fldMahiyat_GardeshId,fldMahiyatId from
--acc.tblCoding_Details  as c 
--inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
--inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
--inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
--where fldCodingId=@IdDetail and (d.fldDocument_HedearId1=h1.fldId or 
--			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
--			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum<>0 
--			group by fldMahiyat_GardeshId,fldMahiyatId
--	)t
--)r
GO
