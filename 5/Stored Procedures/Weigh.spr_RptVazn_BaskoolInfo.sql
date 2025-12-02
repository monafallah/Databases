SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_RptVazn_BaskoolInfo](@azTarikh varchar(10),@TaTarikh varchar(10),@organId int,@fldNoeMasrafId int)
as
--declare @azTarikh varchar(10)='1402/01/01',@TaTarikh varchar(10)='1402/08/08',@organId int=1,@fldNoeMasrafId int=2
if (@fldNoeMasrafId=0)
SeLECT v.[fldId],  case when  fldIsPor=1 then  cast(fldVaznKol as float) else cast(0 as float) end fldVaznKol, cast([fldVaznKhals] as float)[fldVaznKhals],khali.fldTarikhVaznKhali fldTarikhKhali
	,e.fldName  collate  SQL_Latin1_General_CP1_CI_AS+' '+ fldFamily  collate  SQL_Latin1_General_CP1_CI_AS +'('+fldCodemeli+')' as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,case when  fldIsPor=1 then cast(cast(fldDateTazin as time (0))as varchar(8))+' '+ d.fldTarikh else '' end as  fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	 ,fldVaznKhali, case when fldRemittanceId is not null then   TedadKala else 0 end as fldCountHavale,
	case when fldRemittanceId is  null   then 0 else  isnull(cast(fldmaxton as float),0)-cast(SumVazn as float) end  as fldBaghimande
	 ,t.fldName as fldNameKhodro,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	 ,isnull(n.fldName,'') as fldNamMasraf,isnull(fldKalaId,0)fldKalaId,isnull(fldRemittanceId ,0)fldRemittanceId
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldid=fldNoeMasrafId
cross apply (
					 select top(1)cast(cast(fldDateTazin as time (0))as varchar(8))+' '+ d.fldtarikh as fldTarikhKhali,fldTarikhVaznKhali,cast(fldVaznKol as float) as fldVaznKhali 
					 from  Weigh.tblVazn_Baskool vb inner join 
					 com.tblDateDim d on d.fldDate=cast(fldDateTazin AS date)
					 where vb.fldPluqeId=v.fldPluqeId  and vb.fldBaskoolId=v.fldBaskoolId 
					 and fldIsPor=0 and fldOrganId=@organId and v.fldTarikhVaznKhali=vb.fldTarikhVaznKhali
					 order by fldDateTazin desc
)khali



	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS+'('+fldCodemeli+')' as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName+'('+h.fldShenaseMelli+')'  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select isnull(haghighi.fldName,hoghoghi.fldName) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS +'('+fldCodemeli+')' fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName+'('+h.fldShenaseMelli+')' fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
			
			)SumRem						
				

where d.fldTarikh between @azTarikh and @TaTarikh and v.fldOrganId=@organId  and fldIsPor=1
and fldEbtal=0 
order by fldid desc

else 
SeLECT v.[fldId],  case when  fldIsPor=1 then  cast(fldVaznKol as float) else cast(0 as float) end fldVaznKol, cast([fldVaznKhals] as float)[fldVaznKhals],khali.fldTarikhVaznKhali fldTarikhKhali
	,e.fldName  collate  SQL_Latin1_General_CP1_CI_AS+' '+ fldFamily  collate  SQL_Latin1_General_CP1_CI_AS +'('+fldCodemeli+')' as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,case when  fldIsPor=1 then cast(cast(fldDateTazin as time (0))as varchar(8))+' '+ d.fldTarikh else '' end as  fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	 ,fldVaznKhali, case when fldRemittanceId is not null then   TedadKala else 0 end as fldCountHavale,
	case when fldRemittanceId is  null   then 0 else  isnull(cast(fldmaxton as float),0)-cast(SumVazn as float) end  as fldBaghimande
	 ,t.fldName as fldNameKhodro,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	 ,isnull(n.fldName,'') as fldNamMasraf,isnull(fldKalaId,0)fldKalaId,isnull(fldRemittanceId ,0)fldRemittanceId
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldid=fldNoeMasrafId
cross apply (
					 select top(1)cast(cast(fldDateTazin as time (0))as varchar(8))+' '+ d.fldtarikh as fldTarikhKhali,fldTarikhVaznKhali,cast(fldVaznKol as float) as fldVaznKhali 
					 from  Weigh.tblVazn_Baskool vb inner join 
					 com.tblDateDim d on d.fldDate=cast(fldDateTazin AS date)
					 where vb.fldPluqeId=v.fldPluqeId  and vb.fldBaskoolId=v.fldBaskoolId 
					 and fldIsPor=0 and fldOrganId=@organId and v.fldTarikhVaznKhali=vb.fldTarikhVaznKhali
					 order by fldDateTazin desc
)khali



	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS+'('+fldCodemeli+')' as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName+'('+h.fldShenaseMelli+')'  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select isnull(haghighi.fldName,hoghoghi.fldName) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS +'('+fldCodemeli+')' fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName+'('+h.fldShenaseMelli+')' fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
			
			)SumRem						
				

where d.fldTarikh between @azTarikh and @TaTarikh and v.fldOrganId=@organId  and fldIsPor=1
and fldEbtal=0 and fldNoeMasrafId=@fldNoeMasrafId
order by fldid desc
GO
