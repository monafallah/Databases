SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptByCoding]
@CodingId int,
@OrganId int,
@Year smallint,
@ModuleId int
--@Type tinyint
as
begin tran
--declare @CodingId int=30,
--@OrganId int=1,
--@Year smallint=1401,
--@ModuleId int=4

declare @Title nvarchar(max)=''

select @Title=stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=@CodingId
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') 

select isnull(fldBedehkar,0) fldBedehkar,isnull(fldBestankar,0) fldBestankar ,isnull((abs(fldBedehkar-fldBestankar)),0) as MandehHeasb,isnull((fldBedehkar+fldBestankar),0) GardeshHesab,@Title as fldTitle
,case when fldBedehkar-fldBestankar>0 then 1 when fldBedehkar-fldBestankar<0 then 2 else 3 end fldType
 from(select sum(isnull(fldBedehkar,0)) fldBedehkar,sum(isnull(fldBestankar,0)) fldBestankar 
 from acc.tblDocumentRecord_Details as dc inner join
Acc.tblDocumentRecord_Header Header on Header.fldId=fldDocument_HedearId
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=Header.fldid
where 
 (dc.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and dc.fldDocument_HedearId1 is null)) 
	and  fldCodingId=@CodingId and fldOrganId=@OrganId and fldYear=@Year and (fldModuleSaveId=@ModuleId or (fldTypeSanadId in (1,4)))
and h1.fldDocumentNum<>0  -- and (@Type=2 or (@Type<>2 and Header.fldAccept=@Type))
)t


commit tran
GO
