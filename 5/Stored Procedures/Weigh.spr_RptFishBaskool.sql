SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_RptFishBaskool](@id int )
as
--declare @id int=171
select v.fldid,cast(cast(fldVaznKhals as float) as varchar(10))+ISNULL(' ('+cast(fldTedad as varchar(10))+')','') as fldVaznKhals,cast(fldVaznKhali as float)fldVaznKhali, case when  fldIsPor=1 then  cast(fldVaznKol as float) else cast(0 as float) end fldVaznKol,
	 khali.fldTarikhVaznKhali fldTarikhKhali,case when  fldIsPor=1 then cast(cast(fldDateTazin as time (0))as varchar(8))+' '+  d1.fldTarikh else '' end as fldTarikhPor
	,e.fldName+' '+ fldFamily as fldNameRanande,isnull(k.fldName,'') as fldNameKala 
	,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,isnull(n.fldName,'') as fldNamMasraf,w.fldName as fldNameBaskool,
	coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	, Com.fn_stringDecode(o.fldName) as fldNameOrgan,t.fldName as fldNameKhodro,fldTedadKala fldCount,fldSumVazn as fldBaghimande,isnull(fldRemittanceId,0)fldRemittanceId
	from Weigh.tblVazn_Baskool v
	inner join com.tblOrganization o on fldOrganId=o.fldId
	inner join com.tblDateDim d1 on d1.fldDate=cast(fldDateTazin AS date)
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join com.tblTypeKhodro t on t.fldid=fldtypeKhodroId
	left join Weigh.tblNoeMasraf n on n.fldid=fldNoeMasrafId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId

cross apply (
					 select top(1) cast(cast(fldDateTazin as time (0))as varchar(8))+' '+d.fldtarikh as fldTarikhKhali,fldTarikhVaznKhali,cast(fldVaznKol as float) as fldVaznKhali 
					 from  Weigh.tblVazn_Baskool vb inner join 
					 com.tblDateDim d on d.fldDate=cast(fldDateTazin AS date)
					 where vb.fldPluqeId=v.fldPluqeId  and vb.fldBaskoolId=v.fldBaskoolId 
					 and fldIsPor=0 and vb.fldOrganId=v.fldOrganId  and vb.fldTarikhVaznKhali=v.fldTarikhVaznKhali
					 order by fldDateTazin desc
)khali



outer apply (
			select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS as fldNameAshkhas from com.tblAshkhas a
			inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
			where a.fldId=v.fldAshkhasId

			union all

			select h.fldName fldNameAshkhas from com.tblAshkhas a
			inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
			where a.fldId=v.fldAshkhasId

)Ashkhas

outer apply (
			select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
)Chart

outer apply (
				select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle+'('+r.fldTitle+')') as fldNameHavale 
					from Weigh.tblRemittance_Header r
					outer apply (
								select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS fldName from com.tblAshkhas  a inner join 
								com.tblEmployee e on e.fldid=a.fldHaghighiId 
								where a.fldid=r.fldAshkhasiId

							)haghighi

					outer apply (
								select h.fldName from com.tblAshkhas a inner join
								 com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
								where a.fldid=r.fldAshkhasiId

							)hoghoghi

					outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

)Havale

outer apply (
			 select count(v2.fldKalaId)fldTedadKala,fldMaxTon-sum(v2.fldVaznKhals)  as fldSumVazn from weigh.tblVazn_Baskool v2
			 cross apply (select fldMaxTon from weigh.tblRemittance_Details r
						  where r.fldRemittanceId=v2.fldRemittanceId and v2.fldKalaId=r.fldKalaId
						 )rem
			 where v2.fldKalaId=v.fldKalaId and v2.fldRemittanceId=v.fldRemittanceId	
			 group by fldMaxTon


)kolRemittance

where v.fldid=@id

GO
