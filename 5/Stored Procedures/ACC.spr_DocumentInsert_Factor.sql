SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [ACC].[spr_DocumentInsert_Factor]
/*declare*/ @idFactor int ,@organid int,@fldDesc nvarchar(100),@fldIP nvarchar(50),@fldUserId  int

as 
begin try
	begin tran
deCLARE  @SumMablagh bigint,@sal smallint,@M_Bime bigint=0,@M_Hosn bigint=0,@SumMablaghKasr bigint=0
,@Bime decimal(4,2),@Kar decimal(4,2),@tarikh  varchar(10),@Maliyat decimal(5,2),@Avarez  decimal(5,2) 
,@CodingHeader int,@CodeMaliyat int,@sh_Factor varchar(30),@codekol int,@fldDocumentNum int, 
@CodeBime int,@CodeKar int,@salMaliId int,@IdError int

declare @temp table  (id int identity,fldfactorId int,fldMablagh bigint,fldSharh nvarchar(maX),fldcodingdetailid int,fldItemid int,fldPercent int )

/*متغیرهای با داده های ثابت*/
declare @itemMaliyat int=21,
		@itemKol int=20,
		@ItemBime int=42,
		@itemkar int=43,
		@fldModuleSaveId int=10,
		@fldModuleErsalId int=13,
		@fldAccept tinyint=0,
		@fldTypesanad tinyint=2,
		@fldType tinyint=1,
		@fldDescriptionDocu nvarchar(MAX),
		@fldArchiveNum NVARCHAR(50),
		@fldShomareFaree int



/* سال مالی */

select @sal=substring(fldTarikh,1,4),@Bime=fldKasrBime,@Kar=fldKasrHosnAnjamKar 
,@tarikh=fldTarikh,@sh_Factor=fldShomare/*,@fldDescriptionDocu=N'بابت تع'--fldSharhSanad*/
from cntr.tblFactor where fldid=@idFactor

select @salMaliId=fldid from acc.tblFiscalYear where fldYear=@sal and fldOrganId=@organid

/*بدست آوردن آیدی کدینگ هدر*/
select @CodingHeader=fldId from Acc.tblCoding_Header
where fldYear=@sal and fldOrganId=@organid

/*کد مالیات*/
select @CodeMaliyat=c.fldId from acc.tblTemplateCoding as t
inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
where t.fldItemId=@ItemMaliyat and c.fldHeaderCodId=@CodingHeader

/*کد مبلغ کل فاکتور*/
select @codekol=c.fldId from acc.tblTemplateCoding as t
inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
where t.fldItemId=@itemKol and c.fldHeaderCodId=@CodingHeader

/*کد کسر بیمه*/
select @CodeKar=c.fldId from acc.tblTemplateCoding as t
inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
where t.fldItemId=@itemkar and c.fldHeaderCodId=@CodingHeader

/*کد حسن انجام کار*/
select @CodeBime=c.fldId from acc.tblTemplateCoding as t
inner join acc.tblCoding_Details as c on c.fldTempCodingId=t.fldId
where t.fldItemId=@ItemBime and c.fldHeaderCodId=@CodingHeader


/*بدست آوردن مالیات و عوارض*/
SELECT top(1) @Maliyat=fldDarsadeMaliyat,@Avarez=fldDarsadeAvarez FROM COM.tblMaliyatArzesheAfzoode 
where @tarikh between fldFromDate and fldEndDate
ORDER BY fldFromDate DESC,fldEndDate DESC


/********************************************************/
/*کل مبلغ فاکتور*/
select @SumMablagh=sum(fldMablagh)+sum(fldMablaghMaliyat) from cntr.tblFactorDetail where fldHeaderId=@idFactor

/*مبلغ بیمه - حسن انجام کار*/
set @M_Bime=@SumMablagh*@Bime
set @M_Hosn=@SumMablagh*@Kar

/*کسر مبلغ کسورات از مبلغ کل*/
set @SumMablaghKasr=@SumMablagh-(@M_Bime+@M_Hosn)

/*بدست آوردن مبالغ هر رکورد*/
;with Factor as(
select fldheaderid, (fldMablaghMaliyat/(@SumMablaghKasr*fldMablagh))  fldMablagh 
,SUBSTRING(CAST(@Maliyat AS NVARCHAR(10)),1,LEN(@Maliyat)-3) +N'%'+N'مالیات' as fldSharheCodeDaramad
,SUBSTRING(CAST(@Maliyat AS NVARCHAR(10)),1,LEN(@Maliyat)-3) fldpercent,
@CodeMaliyat fldCoding,@itemMaliyat fldItemId
from Cntr.tblFactorDetail
where fldTax=1 and fldHeaderId=@idFactor

union all

select fldheaderid, (fldMablagh/(@SumMablagh*@SumMablaghKasr))fldMablagh
,fldSharhArtikl,0 fldpercent,fldCodingDetailId,0 fldItemId
from cntr.tblFactorDetail
where fldHeaderId=@idFactor
)

insert into @temp
select fldHeaderId,mablaghNahaee,fldSharheCodeDaramad,fldCoding,fldItemId,fldpercent from (
	select *
	,case when rowId=MAX(rowId) over (partition by fldheaderid) and mablaghEkhtelaf<>0 then fldMablagh-mablaghEkhtelaf else fldMablagh end as mablaghNahaee from 
		(select row_number ()over (partition by fldheaderid  order by fldheaderid)rowId,
		sum(fldMablagh) over (partition by fldheaderid)-@SumMablaghKasr  as   mablaghEkhtelaf,*/*بدست آوردن مبلغ آخرین رکورد برا تراز  بود با مبلغ اصلی*/
		 from  factor 
		 )t
)s

/*************************************************************/
/*شماره سند*/
select @fldDocumentNum=ISNULL(max(h1.fldDocumentNum),0)+1 from [ACC].[tblDocumentRecord_Header] as h
					 inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
					where h.fldOrganId=@organid and tblFiscalYear.fldid=@salMaliId
					and h1.fldModuleSaveId=@fldModuleSaveId


declare @idDocHeader int,@IDHeader1 int,@fldDetailID int,@fldCaseId int 

select @idDocHeader =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header] 
INSERT INTO [ACC].[tblDocumentRecord_Header] ([fldId],  [fldDescriptionDocu],fldYear,[fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldType,fldFiscalYearId)
SELECT @idDocHeader,   @fldDescriptionDocu,@sal,@organid,@fldDesc, GETDATE(), @fldIP, @fldUserId,@fldType,@salMaliId


select @IDHeader1 =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Header1] 
INSERT INTO [ACC].[tblDocumentRecord_Header1] ([fldId],fldDocument_HedearId, [fldDocumentNum], [fldArchiveNum], [fldTarikhDocument],  [fldDate], [fldIP], [fldUserId],[fldAccept],fldModuleSaveId ,fldModuleErsalId,fldShomareFaree,fldTypeSanadId,fldPid,fldEdit)
SELECT @IDHeader1,@idDocHeader, @fldDocumentNum, @fldArchiveNum, @tarikh , GETDATE(), @fldIP, @fldUserId,@fldAccept,@fldModuleSaveId ,@fldModuleErsalId,@fldShomareFaree,@fldTypesanad,null,2


select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
select  row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,CodeMaliyat,fldSharheCodeDaramad,fldMablagh,fldBestan,fldCenterCoId,fldCaseId,fldDesc,fldDate,fldIP,fldUserId,fldOrder from(
SELECT  @idDocHeader as Document_HedearId,@IDHeader1 as Document_HedearId1 , @CodeMaliyat CodeMaliyat,cast( sum(fldPercent) as varchar(10))+N'%'+N'مالیات ' as fldSharheCodeDaramad,  sum(t.fldMablagh) fldMablagh,0 fldBestan, null as fldCenterCoId, null as fldCaseId, @fldDesc as fldDesc, GETDATE() as fldDate, @fldIP as fldIP, @fldUserId as fldUserId,1  as fldOrder
from @temp as t where fldItemId in (21) 
group by fldPercent
union
SELECT  @idDocHeader,@IDHeader1, fldcodingdetailid, t.fldSharh,  t.fldMablagh,0, null, null, @fldDesc, GETDATE(), @fldIP, @fldUserId,t.id 
from @temp as t where fldItemId =0

)t
union all
select   row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,codebime,fldsharh,mablagh,0,NULL fldCenterCoId,NULL fldCaseId,@fldDesc ,getdate() fldDate,@fldIP ,@fldUserId fldUserId,1 fldOrder 
from
	 (select  @idDocHeader Document_HedearId ,@IDHeader1 Document_HedearId1,@CodeBime codebime ,N'کسر بیمه' fldsharh,@M_Bime as mablagh,@ItemBime itembime,@Bime bime
	) s where bime<>0/*Bime*/

union all
select   row_number() over (order by (select 1))+@fldDetailID,Document_HedearId,Document_HedearId1,codebime,fldsharh,mablagh,0,NULL fldCenterCoId,NULL fldCaseId,@fldDesc ,getdate() fldDate,@fldIP ,@fldUserId fldUserId,1 fldOrder 
from
	 (select  @idDocHeader Document_HedearId ,@IDHeader1 Document_HedearId1,@CodeKar codebime ,N'حسن انجام کار' fldsharh,@M_Hosn as mablagh,@itemkar itembime,@Kar Kar
	) y where kar<>0 /*HosnAnjamKar*/

/*************************************************/
--case
select @fldCaseId=fldId from [ACC].[tblCase] where fldCaseTypeId=13 and fldSourceId=@idFactor
		if(@fldCaseId is null or @fldCaseId=0)
		begin
			select @fldCaseId =ISNULL(max(fldId),0)+1 from [ACC].[tblCase] 
						INSERT INTO [ACC].[tblCase] ([fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId])
						SELECT @fldCaseId, 3, @idFactor, '', GETDATE(), @fldIP, @fldUserId 
					
		end


select @fldDetailID =ISNULL(max(fldId),0)+1 from [ACC].[tblDocumentRecord_Details] 
INSERT INTO [ACC].[tblDocumentRecord_Details] ([fldId], [fldDocument_HedearId],[fldDocument_HedearId1], [fldCodingId], [fldDescription], [fldBedehkar], [fldBestankar], [fldCenterCoId], [fldCaseId], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrder)
SELECT @fldDetailID, @idDocHeader,@IDHeader1, @CodingHeader,N'بابت تایید شماره فاکتور '+@sh_Factor, 0,@SumMablagh, null, @fldCaseId, @fldDesc, GETDATE(), @fldIP, @fldUserId,1
						
commit tran
end try
begin catch
rollback

select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'spr_DocumentInsert_Factor',getdate() from com.tblUser where fldid=@fldUserId
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
end catch
GO
