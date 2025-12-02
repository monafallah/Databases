SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblVazn_BaskoolSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@moduleId int,
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
					and fldEbtal=0
			)SumRem		

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez
	WHERE  v.fldId=@Value --and v.fldOrganId =@organId
	order by fldid desc

	if (@FieldName='fldNameRanande')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName++'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						
				
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	

	WHERE  fldNameRanande like @Value and fldOrganId =@organId
	order by fldid desc

	if (@FieldName='fldNameKala')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName++'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi
		outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem	
				
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez

	WHERE  k.fldName like @Value and v.fldOrganId =@organId
	order by fldid desc


	if (@FieldName='fldBaskoolId')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi
			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E


				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem	
			
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				

	WHERE  fldBaskoolId like @Value and v.fldOrganId =@organId
	order by fldid desc

	


	if (@FieldName='fldPlaque')
	SELECT top(@h) * from (SELECT  v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
	outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem					
			
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez			
				
				)t
	WHERE  fldPlaque like @Value and fldOrganId =@organId
	order by fldid desc

	if (@FieldName='fldDesc')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem		

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez

	WHERE  v.fldDesc like @Value and  v.fldOrganId =@organId
	order by fldid desc

	if (@FieldName='')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end  as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart



outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem	
				
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez

	where  v.fldOrganId =@organId
	order by fldid desc

	if (@FieldName='fldOrganId')
	SELECT top(@h) v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

		outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale

outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem	
				
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez
	where  v.fldOrganId =@organId
	order by fldid desc

	if (@FieldName='fldTarikh_TimeTozin')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end  as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi
			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E


				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez								
				
				)t
	where  fldTarikh_TimeTozin like @value and fldOrganId =@organId
	order by fldid desc

		if (@FieldName='fldVaznKhals')
	SELECT top(@h)* from (SELECT  v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end  as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				
				)t
	where  fldVaznKhals like @value and fldOrganId =@organId
	order by fldid desc
	
		if (@FieldName='fldVaznKol')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem	
								
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where  fldVaznKol like @value and fldOrganId =@organId
	order by fldid desc


		if (@FieldName='fldTarfHesab')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem		
							
outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where  fldTarfHesab like @value and fldOrganId =@organId
	order by fldid desc


		if (@FieldName='fldNameMasraf')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')'else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where  fldNameMasraf like @value and fldOrganId =@organId
	order by fldid desc



	if (@FieldName='fldIsporName')
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where  fldIsporName like @value and fldOrganId =@organId
	order by fldid desc


if (@FieldName='LastChart')/*farghdare*/
	SELECT top(1)* from (SELECT  v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

		outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where fldBaskoolId=@value and fldNoeMasrafId=1 and fldOrganId=@organId and  fldEbtal=0
	order by fldid desc



if (@FieldName='ForooshAdi')/*farghdare*/
	SELECT top(@h)* from (SELECT v.[fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], v.[fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], v.[fldUserId], v.[fldOrganId], v.[fldDesc], v.[fldDate], v.[fldIP] 
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,fldIsPor,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali,TedadKala as fldCountHavale,isnull(fldmaxton,0)-SumVazn as fldBaghimande
	,fldTypeKhodroId ,t.fldName as fldNameKhodro,isnull(Ashkhas.fldNameAshkhas,'')fldNameAshkhas,isnull(Chart.fldNameChart,'')fldNameChart,isnull(Havale.fldNameHavale,'') as fldNameHavale
	,case when n.fldid=3 then n.fldName+'  ('+h.fldtitle+')' else isnull(n.fldName,'')  end as fldNameMasraf,coalesce(Ashkhas.fldNameAshkhas,Chart.fldNameChart,Havale.fldNameHavale,'') as fldTarfHesab
	,fldIsprint,fldEbtal,isnull(fldElamAvarezId,0)fldElamAvarezId,isnull(Elamavarez.fldid,0)fldFishId,v.fldTedad,v.fldTypeMohasebe
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	left join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance
	outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameAshkhas from com.tblAshkhas a
				inner join Com.tblEmployee e on  e.fldid=a.fldHaghighiId
				where a.fldId=v.fldAshkhasId

				union all

				select h.fldName  fldNameAshkhas from com.tblAshkhas a
				inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
				where a.fldId=v.fldAshkhasId

				)Ashkhas

outer apply (select c.fldTitle as fldNameChart  from com.tblChartOrganEjraee c
			where c.fldid=v.fldChartOrganEjraeeId
			
			)Chart

outer apply (select coalesce(haghighi.fldName,hoghoghi.fldName,chart_E.fldtitle) as fldNameHavale 
			 from Weigh.tblRemittance_Header r
			outer apply (select fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate  SQL_Latin1_General_CP1_CI_AS    fldName from com.tblAshkhas  a inner join 
						com.tblEmployee e on e.fldid=a.fldHaghighiId 
						where a.fldid=r.fldAshkhasiId

					)haghighi

			outer apply (select h.fldName fldName from com.tblAshkhas a inner join
						com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
						where a.fldid=r.fldAshkhasiId

					)hoghoghi

			outer apply (select c.fldTitle from com.tblChartOrganEjraee c
						where c.fldid=r.fldChartOrganEjraeeId

					)Chart_E

				where r.fldid=v.fldRemittanceId

				)Havale
				
outer apply (	select sum(fldVaznKhals)SumVazn,count(*)TedadKala from Weigh.tblVazn_Baskool vbl
					where vbl.fldBaskoolId=v.fldBaskoolId and vbl.fldKalaId=v.fldKalaId and vbl.fldRemittanceId=v.fldRemittanceId
						and fldEbtal=0
			)SumRem						

outer apply ( select fldElamAvarezId,fish.fldid from weigh.tblElamAvarez_ModuleOrgan e
									inner join com.tblModule_Organ m on m.fldid=e.fldModulOrganId
				outer apply (select fldid from (select  max(fldid)fldid from drd.tblSodoorFish  s
								where s.fldElamAvarezId=e.fldElamAvarezId )f 
								 where not exists (select * from drd.tblEbtal where fldFishId=f.fldid))fish
				where id=v.fldid and fldModuleId=@moduleId and m.fldOrganId=@organId

			)Elamavarez				
				)t
	where  fldKalaId like @value and fldOrganId =@organId and fldNoeMasrafId=2
	order by fldid desc


	COMMIT
GO
