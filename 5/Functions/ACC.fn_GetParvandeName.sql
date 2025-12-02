SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [ACC].[fn_GetParvandeName] (@CaseType int,@SourceId int,@OrganId INT)
returns nvarchar(500)
begin
--declare @CaseId int=178
declare @Name nvarchar(500)=''


if(@CaseType=1)			
	select @Name=fldname  collate SQL_Latin1_General_CP1_CI_AS +'_'+fldFamily collate SQL_Latin1_General_CP1_CI_AS+'('+fldCodemeli+')'  from com.tblEmployee e where e.fldid=@SourceId 
			
if(@CaseType=2)
	select @Name=fldName+ '('+fldShenaseMelli+')'  from com.tblAshkhaseHoghoghi a where a.fldid=@SourceId 

if(@CaseType IN (13,14)) 
	select @Name=N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')'  from Cntr.tblContracts c
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom 
				 where c.fldid=@SourceId 

if(@CaseType=3)
	select @Name=fldBabat+'('+fldShomareSanad+')'   from drd.tblCheck c where c.fldid=@SourceId
				
if(@CaseType=4)
	select @Name=N'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')'   from chk.tblSodorCheck c where c.fldid=@SourceId


	
if(@CaseType=6)
	select @Name=cast(c.fldid as varchar(30))+'_'+Nameshakhs.fldName  
						from drd.tblSodoorFish c  
						inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
						cross apply (
										select fldName  collate SQL_Latin1_General_CP1_CI_AS+' '+fldFamily  collate SQL_Latin1_General_CP1_CI_AS+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli from com.tblAshkhas a inner join com.tblEmployee e 
										on e.fldid=fldHaghighiId
										LEFT JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
										where a.fldid=fldAshakhasID
										union all
										select fldName  collate SQL_Latin1_General_CP1_CI_AS +'('+fldShenaseMelli+')' ,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
										on h.fldid=fldHoghoghiId
										where a.fldid=fldAshakhasID
								)Nameshakhs
						where c.fldid=@SourceId AND  not exists (select * from drd.tblEbtal where fldFishId=c.fldid) 

if(@CaseType=15)
	select @Name=c.fldTitle+'('+c.fldCode+'_'+cast(h.fldYear as varchar(4))+')'  from bud.tblCodingBudje_Details  c inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=c.fldHeaderId 
	where c.fldCodeingBudjeId=@SourceId --and fldType=1 

if(@CaseType=5)
			select @Name=s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  /*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' */
			 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId		   
						  where s.fldid=@SourceId and o.fldid=@OrganId

if(@CaseType=12)
	select @Name=N'فاکتور شماره '+fldShomare   from  cntr.tblFactor c where c.fldid=@SourceId

	return @name  
end

GO
