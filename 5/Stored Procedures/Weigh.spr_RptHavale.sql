SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_RptHavale](@fldhavaleid int )
as 
select fldtitle,Nameshakhs.fldName ,fldMaxTon,k1.fldName as fldNameKala ,fldKalaId,fldControlLimit
,header.fldEndDate,header.fldStartDate,case when header.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName
,cast(sumVazn as float) as fldSumKala,cast(fldMaxTon-(sumVazn)as float) as fldBaghimande ,vaznbaskool.*,
case when fldIdVazn is not null then 1 else 0 end as ExsistVazn
from weigh.tblRemittance_Header header 
inner join Weigh.tblRemittance_Details d 
inner join com.tblKala k1 on k1.fldid=fldKalaId
on d.fldRemittanceId=header.fldid
cross apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=header.fldAshkhasiId

				union all	

			select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=header.fldAshkhasiId
				
				union all
				select c.fldTitle fldName from com.tblChartOrganEjraee c
				where c.fldid=header.fldChartOrganEjraeeId

)Nameshakhs
outer apply (select isnull(sum(fldVaznKhals),0)sumVazn from Weigh.tblVazn_Baskool v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId
					and fldEbtal=0
			)vazn


outer apply (SELECT v.[fldId] fldIdVazn, cast([fldVaznKol] as float)[fldVaznKol], cast([fldVaznKhals] as real)[fldVaznKhals],  [fldRemittanceId], [fldTarikhVaznKhali]
		,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
		,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
		,cast(fldVaznKol-fldVaznKhals as float) as fldVaznKhali
		,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
		FROM   [Weigh].[tblVazn_Baskool] v
		inner join Com.tblEmployee e on e.fldid =fldRananadeId
		inner join com.tblPlaque p on p.fldid=fldPluqeId
		inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
		inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
		inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
		inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
		left join com.tblKala k on k.fldid=fldKalaId
		left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
		left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
		outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
					where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
					)Remittance
					where fldRemittanceId=@fldhavaleid and k1.fldId=v.fldKalaId
					and fldebtal=0
					)vaznbaskool


where header.fldid=@fldhavaleid
GO
