SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_SelectVaznKhals_VaznKhali]
  @Haraf nvarchar(1),
    @Plaque1 varchar(2),
	@Plaque2 varchar(3),
	@serial tinyint,
	@fldBaskoolId int,
	@OrganId int,
	@vaznKol decimal(13,3),
	@Type bit
as
begin tran	
	declare @fldID int,@fldPluqeId int,@fldPlaque nvarchar(13),@TarikhVaznKhali nvarchar(20),@fldVaznKol decimal(15,3),@vaznkhals decimal(15,3)
	
	set @fldPlaque='-'+@Plaque2+@Haraf+@Plaque1 
	
	select @fldPluqeId=fldid from [Com].[tblPlaque] where fldSerialPlaque=@serial and fldPlaque=@fldPlaque  
if (@Type=0)
begin
	select @TarikhVaznKhali=fldTarikhVaznKhali,@fldVaznKol=fldVaznKol,@vaznkhals=VaznKhals.fldVaznKhals 
	from Weigh.tblVazn_Baskool v

	 cross apply (
				 select max(fldDateTazin)MaxDate from  Weigh.tblVazn_Baskool v
				 where  fldPluqeId=@fldPluqeId and fldIsPor=0 and fldBaskoolId=@fldBaskoolId  and fldOrganId=@OrganId
				 and fldebtal=0
	)m_date

	outer apply (
				select top(1) fldVaznKhals from Weigh.tblVazn_Baskool v
				where fldPluqeId=@fldPluqeId and  fldBaskoolId=@fldBaskoolId and fldispor=1  and fldOrganId=@OrganId --and fldDateTazin>MAXdate
				 and fldebtal=0
				order by fldDateTazin desc
	)VaznKhals

	where fldPluqeId=@fldPluqeId and  fldBaskoolId=@fldBaskoolId and MaxDate=fldDateTazin and fldOrganId=@OrganId
	 and fldebtal=0 and fldIsPor=0

	select isnull(@TarikhVaznKhali,'')TarikhVaznKhali 
	,case when @vaznKol=0 then  0/*isnull(@vaznkhals,0.0)*/ else isnull(@vaznKol-@fldVaznKol,0.0) end fldVaznKhals,isnull(@fldVaznKol,0.0)fldVaznKhali
	,case when (datediff(MINUTE, com.ShamsiToMiladi( substring(@TarikhVaznKhali,10,len(@TarikhVaznKhali)))+substring(@TarikhVaznKhali,1,8),getdate()))<=1440/*24 ساعت به دقیقه این عدد میشود*/
 then cast( 1 as bit) else cast(0  as bit)end as lastHour
end
if (@Type=1)
begin
	select top(1) @TarikhVaznKhali=cast(cast(fldDateTazin as time (0)) as varchar(8))+' '+dbo.Fn_AssembelyMiladiToShamsi( fldDateTazin),@fldVaznKol=fldVaznKol--,@vaznkhals=VaznKhals.fldVaznKhals 
	
	from Weigh.tblVazn_Baskool v

	/* cross apply (
				 select max(fldDateTazin)MaxDate from  Weigh.tblVazn_Baskool v
				 where  fldPluqeId=@fldPluqeId and fldIsPor=0 and fldBaskoolId=@fldBaskoolId  and fldOrganId=@OrganId
				 and fldebtal=0
	)m_date

	outer apply (
				select top(1) fldVaznKol from Weigh.tblVazn_Baskool v
				where fldPluqeId=@fldPluqeId and  fldBaskoolId=@fldBaskoolId and fldispor=0  and fldOrganId=@OrganId --and fldDateTazin>MAXdate
				 and fldebtal=0
				order by fldDateTazin desc
	)VaznKhals*/

	where fldPluqeId=@fldPluqeId and  fldBaskoolId=@fldBaskoolId  and fldOrganId=@OrganId
	 and fldebtal=0 and fldIsPor=1
	 order by fldDate desc

	select isnull(@TarikhVaznKhali,'')TarikhVaznKhali,case when @vaznKol=0 then  0/*isnull(@vaznkhals,0.0)*/ else isnull(@vaznKol-@fldVaznKol,0.0) end fldVaznKhals,isnull(@fldVaznKol,0.0)fldVaznKhali
,case when (datediff(MINUTE, com.ShamsiToMiladi( substring(@TarikhVaznKhali,10,len(@TarikhVaznKhali)))+substring(@TarikhVaznKhali,1,8),getdate()))<=1440/*24 ساعت به دقیقه این عدد میشود*/
 then cast( 1 as bit) else cast(0  as bit)end as lastHour
end


commit
GO
