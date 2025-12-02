SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectRannadeInPlaque]
@fieldName nvarchar(15),
  @fldSerialPlaque tinyint,
    @Haraf nvarchar(1),
    @Plaque1 varchar(2),
	@Plaque2 varchar(3),
	@BaskoolId int,
	@OrganId int
as
begin tran 
declare @fldPlaque nvarchar(13),@fldP_Id int,@fldRananadeId int,@fldNameRanande nvarchar(200),@Ispor bit =0,@fldNameKhodro nvarchar(100)='',@typeKhodro int
	set @fldPlaque='-'+@Plaque2+@Haraf+@Plaque1 
select @fldP_Id=fldid from [Com].[tblPlaque] where fldSerialPlaque=@fldSerialPlaque and fldPlaque=@fldPlaque
if (@fieldName='Ranande')
begin
	select top(1) @fldRananadeId=fldRananadeId,@fldNameRanande=e.fldName+' '+ fldFamily,@fldNameKhodro=fldNameKhodro,@typeKhodro=khodro.fldTypeKhodroId  
	from Weigh.tblVazn_Baskool v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	outer apply (
				select t1. fldNameKhodro,t1.fldTypeKhodroId,id from (select  t.fldName as fldNameKhodro,e.fldTypeKhodroId,e.fldid id  from Weigh.tblVazn_Baskool e inner join com.tblTypeKhodro t
				on t.fldid=fldtypeKhodroId
				where  e.fldRananadeId=v.fldRananadeId and e.fldPluqeId=v.fldPluqeId and e.fldOrganId=@OrganId
				 and fldEbtal=0)t1
				)khodro
	where fldPluqeId=@fldP_Id and  fldBaskoolId=@BaskoolId and fldOrganId=@OrganId  and fldEbtal=0
	order by v.fldid desc
	select isnull(@fldRananadeId,0)fldRananadeId,isnull(@fldNameRanande,'')fldNameRanande,cast(0 as bit) IsKhali,isnull(@fldNameKhodro ,'')fldNameKhodro,isnull(@typeKhodro,0)fldTypeKhodro

end

if (@fieldName='ExistsKhali')
begin

	--select top(1) @Ispor=1 from   Weigh.tblVazn_Baskool v
	--where fldPluqeId=@fldP_Id and fldBaskoolId=@BaskoolId and fldIspor=0 and fldOrganId=@OrganId  and fldEbtal=0
	--order by fldDateTazin desc

	select @Ispor=cast(1 as bit) from Weigh.tblVazn_Baskool 
	where fldPluqeId=@fldP_Id and fldBaskoolId=@BaskoolId and cast(fldDate as date)=cast(getdate() as date)
	and fldIsPor=0 and fldEbtal=0 and fldOrganId=@OrganId

	select 0fldRananadeId,''fldNameRanande, isnull(@Ispor,cast(0 as bit))IsKhali/*اگر وزن خالی برای ان پلاک بود خروجی 1 میدهد*/,''fldNameKhodro,0 fldTypeKhodro

end

commit
GO
