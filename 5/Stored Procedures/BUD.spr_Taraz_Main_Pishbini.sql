SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--USE [RasaNewFMS]
--GO
--/****** Object:  StoredProcedure [ACC].[spr_Taraz]    Script Date: 8/15/2023 10:39:54 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE proc [BUD].[spr_Taraz_Main_Pishbini]
 --declare 
 @aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azLevel int,@tanLevel int,@azsanad int,@tasanad int,@StartNodeID int,@sanadtype tinyint
 as
 begin
----initial Values
--select @aztarikh='1402/01/01',@tatarikh='1402/05/31',@salmaliID=5,@organid=1,
--@StartNodeID=0,@azLevel=1,@tanLevel=6,@sanadtype=2

-----------
declare @tatarikhmah tinyint=SUBSTRING(@tatarikh,6,2)
declare @sal int=cast(SUBSTRING(@tatarikh,1,4) as int)
declare @accept1 tinyint,@accept2 tinyint

set @accept1=0
set @accept2=1
if (@sanadtype=1 or @sanadtype=0) 
begin
	set @accept1=@sanadtype
	set @accept2=@sanadtype
end
declare @StartNodeHID   hierarchyid=(select fldCodeId from acc.tblCoding_Details t where t.fldId=@StartNodeID)
if (@azsanad = 0 or @azsanad is null) set @azsanad=1
if (@tasanad = 0 or @tasanad is null) set @tasanad=2147483647 

--header table=ACC.tblDocumentRecord_Header
--header main=ACC.tblDocumentRecord_Header1
;with Sanad
as
( 
SELECT       fldTarikhDocument, fldAccept, fldDocumentNum, h.fldId, hp.fldTypeSanadId,case SUBSTRING(fldTarikhDocument,6,2) when @tatarikhmah then 1 else 0 end fldmahsanad
FROM         acc.tblDocumentRecord_Header as h inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId AND  h.fldType = 1 AND hp.fldDocumentNum > 0 AND h.fldFiscalYearId = @salmaliID AND h.fldOrganId =  @organid AND 
                         hp.fldModuleSaveId = 4 and fldTarikhDocument>=@aztarikh and fldTarikhDocument<=@tatarikh and fldDocumentNum>=@azsanad and fldDocumentNum<=@tasanad and hp.fldAccept>=@accept1 and hp.fldAccept<=@accept2

)
,Coding(fldId, fldCodeId,fldLevelId,fldTitle,fldCode)
as
(
	SELECT        d.fldId, d.fldCodeId,d.fldLevelId,d.fldTitle,d.fldCode
FROM            ACC.tblCoding_Details as d inner join ACC.tblCoding_Header as h on h.fldId=d.fldHeaderCodId where h.fldYear=@sal and h.fldOrganId=@organid and d.fldCodeId.IsDescendantOf(@StartNodeHID)=1
)
,artikl(fldCodingId, fldBedehkar, fldBestankar, fldCaseId,fldmahsanad)
as
(
	SELECT        fldCodingId, fldBedehkar, fldBestankar,ISNULL(fldCaseId,0),a.fldmahsanad
FROM            sanad a inner join ACC.tblDocumentRecord_Details as d on d.fldDocument_HedearId=a.fldId  inner join Coding on d.fldCodingId=Coding.fldId 
)

--آخرین سطح که شامل پرونده است
,d(fldCodingId,fldCaseId, fldcount)
as
(
	select fldcodingid,fldCaseId,count(fldcodingid) from artikl c group by fldCodingId,fldCaseId
)
,dp(fldCodingId, fldcount)
as
(
	select fldcodingid,count(fldcodingid) from d group by fldCodingId
)--select * from dp
--جمع بدهکار و بستانکار آخرین سطح که شامل پرونده است
,dd(fldCodingId, fldBedehkar, fldBestankar,fldmahsanad)
as
(
		select c.fldCodingId,sum(c.fldBedehkar),sum(c.fldBestankar),c.fldmahsanad from artikl c inner join dp on c.fldCodingId=dp.fldCodingId and dp.fldcount>1
		group by c.fldCodingId,c.fldmahsanad
)
,artiklh(fldhid,fldCodingId, fldBedehkar, fldBestankar, fldCaseId,fldmahsanad)
as
(
	select Coding.fldCodeId,c.* from Coding  inner join artikl c on Coding.fldId=c.fldCodingId
	
	
),
codingup(fldhid,fldCodingId, fldBedehkar, fldBestankar, fldCaseId,fldmahsanad,fldflag)
as
(
	select *,1 from  artiklh
	union all
	select e.fldCodeId,e.fldId,g.fldBedehkar,g.fldBestankar,-1,g.fldmahsanad,0 from Coding e  inner join codingup g on g.fldhid.GetAncestor(1)=e.fldCodeId
),codingsum(fldCode, fldBedehkar, fldBestankar, fldCaseId,fldmahsanad,fldflag)
as
(
	select fldCodingId,sum(fldBedehkar) , sum(fldBestankar),fldCaseId ,fldmahsanad,fldflag from codingup g group by fldCodingId,fldcaseid,fldmahsanad,fldflag
	union all
	select fldCodingId,fldBedehkar,fldBestankar,-1,fldmahsanad,0 from dd

),DistCode(fldCode,fldCaseId)
as
(
	select fldCode,fldCaseId from codingsum group by fldCode,fldCaseId
)
,codingsumTaraz(fldCode, bed_g, bes_g, bed_m, bes_m, fldCaseId,fldflag)
as
(
	select d.fldCode,isnull(c1.fldBedehkar,0),isnull(c1.fldBestankar,0),isnull(c2.fldBedehkar,0),isnull(c2.fldBestankar,0),d.fldCaseId,isnull(c1.fldflag,c2.fldflag) from DistCode d left join codingsum c1 on d.fldCode= c1.fldCode and d.fldCaseId=c1.fldCaseId and c1.fldmahsanad=0 left join codingsum c2 on d.fldCode= c2.fldCode and d.fldCaseId=c2.fldCaseId and c2.fldmahsanad=1

)
,final( fldCode,bed_g, bes_g, bed_m, bes_m,bed,bes,mbed,mbes ,fldCaseId,fldflag)
as
(	
	select fldCode, bed_g, bes_g, bed_m, bes_m,bed_g+bed_m,bes_g+bes_m,
	case  when (bed_g+bed_m-bes_g-bes_m)>0 then abs((bed_g+bed_m-bes_g-bes_m)) else 0 end  ,
	case  when (bed_g+bed_m-bes_g-bes_m)<0 then abs((bed_g+bed_m-bes_g-bes_m)) else 0 end ,fldCaseId,fldflag from codingsumTaraz s 
)
,final8(fldHid,fldcode,fldLevelId,fldTitle,fldid, bed_g, bes_g, bed_m, bes_m,bed,bes,mbed,mbes, fldCaseName,fldflag,fldCaseTypeId)
as 
(	
	select c.fldCodeId, c.fldCode,c.fldLevelId,c.fldTitle,s.fldCode,bed_g, bes_g, bed_m, bes_m,bed,bes,mbed,mbes, case when fldflag=1 and s.fldCaseId!=0 then acc.fn_GetParvandeName(ca.fldCaseTypeId,ca.fldSourceId,@organid) when fldflag=1 and s.fldCaseId=0 and dp.fldcount>1 then N'پرونده عمومی' else '' end,
	case when c.fldLevelId=@tanLevel or fldflag=1 then 1 else 0 end ,fldCaseTypeId from final s inner join Coding c on s.fldCode=c.fldId left join ACC.tblCase ca on s.fldCaseId=ca.fldId left join dp on s.fldCode=dp.fldCodingId where fldLevelId>=@azLevel and fldLevelId<=@tanLevel
)
,final8H(fldHid,fldcode,fldLevelId,fldTitle,fldid, bed_g, bes_g, bed_m, bes_m,bed,bes,mbed,mbes, fldCaseName,fldflag,fldCaseTypeId)
as 
(	
	select f.* from final8 f inner join acc.tblCoding_Details d on f.fldid=d.fldId
)		
select *,@aztarikh fldAztarikh,@tatarikh fldTaTarikh from final8H
end
GO
