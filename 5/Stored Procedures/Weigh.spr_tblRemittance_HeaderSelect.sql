SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_HeaderSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	WHERE  r.fldId=@Value and r.fldorganId=@organId
	order by r.fldId desc
	
	if (@FieldName='fldDesc')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	WHERE  r.fldDesc like @Value and r.fldorganId=@organId
	order by r.fldId desc

	if (@FieldName='fldTitle')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	WHERE  r.fldTitle like @Value and r.fldorganId=@organId
	order by r.fldId desc

	if (@FieldName='fldOrganId')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	WHERE  r.fldorganId=@organId
	order by r.fldId desc

	if (@FieldName='')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					WHERE  r.fldorganId=@organId
	order by r.fldId desc


if (@FieldName='fldStatusName')
	select  top(@h)* from(SELECT r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					where fldStatusName like @Value
	order by fldId desc

	if (@FieldName='fldFamilyName')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					where fldFamilyName like @Value
	order by fldId desc


if (@FieldName='fldNameChart')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					where fldNameChart like @Value
	order by fldId desc


if (@FieldName='fldNameAshkhas_Chart')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					where fldNameAshkhas_Chart like @Value
	order by fldId desc



if (@FieldName='fldTypeShakhs')
	select top(@h)* from(SELECT r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					where fldTypeShakhs like @Value
	order by fldId desc


	if (@FieldName='fldCodemeli')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
				
					where Ashkahs.fldCodemeli like @Value
	order by fldId desc

	if (@FieldName='fldKalaName')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
				
					where fldKalaName like @Value
	order by fldId desc

	if (@FieldName='fldStartDate')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
				
					where fldStartDate like @Value
	order by fldId desc

	if (@FieldName='fldEndDate')
SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
				
					where fldEndDate like @Value
	order by fldId desc

---------------------------------------------------------havalepor
	if (@FieldName='fldTitle_havalePor')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv
	WHERE  r.fldTitle like @Value and r.fldorganId=@organId
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc
	

	if (@FieldName='havalePor')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv
					WHERE  r.fldorganId=@organId
	--order by case when isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc

if (@FieldName='fldStatusName_havalePor')
	select  top(@h)* from(SELECT r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart

					)t
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= T.fldid  group by fldRemittanceId)		vv
					where fldStatusName like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else t.flddate  end desc 
	order by  d desc

	if (@FieldName='fldFamilyName_havalePor')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= t.fldid  group by fldRemittanceId)		vv
					where fldFamilyName like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else t.flddate  end desc 
	order by  d desc

if (@FieldName='fldNameChart_havalePor')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
					outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= t.fldid  group by fldRemittanceId)		vv
					where fldNameChart like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else t.flddate  end desc 
	order by  d desc

if (@FieldName='fldNameAshkhas_Chart_havalePor')
	select top(@h)* from(SELECT  r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= t.fldid  group by fldRemittanceId)		vv
					where fldNameAshkhas_Chart like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else t.flddate  end desc 
	order by  d desc


if (@FieldName='fldTypeShakhs_havalePor')
	select top(@h)* from(SELECT r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
					)t
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= t.fldid  group by fldRemittanceId)		vv
					where fldTypeShakhs like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else t.flddate  end desc 
	order by  d desc

	if (@FieldName='fldCodemeli_havalePor')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv			
					where Ashkahs.fldCodemeli like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc

	if (@FieldName='fldKalaName_havalePor')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv			
					where fldKalaName like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc

	if (@FieldName='fldStartDate_havalePor')
	SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv	
					where fldStartDate like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc

	if (@FieldName='fldEndDate_havalePor')
SELECT top(@h) r.[fldId], [fldAshkhasiId], r.[fldStatus], [fldStartDate], [fldEndDate], r.[fldUserId], r.[fldOrganId], r.[fldDesc]
	, r.[fldDate], r.[fldIP] ,case when r.fldStatus=0 then N'غیر فعال' else N'فعال' end as fldStatusName,d.fldKalaName
	,Ashkahs.fldTypeShakhs	, fldFamilyName,Ashkahs.fldCodemeli,r.fldTitle,fldNameChart,isnull(fldFamilyName,fldNameChart)fldNameAshkhas_Chart,
	fldEmployId,fldChartOrganEjraeeId,
	case when fldAshkhasiId is not null then N'پیمانکاری' when fldChartOrganEjraeeId is not null then N'امانی' end as fldNameNoeHavale
	,em.fldName+' '+em.fldFamily as fldNameTahvilGirande,fldFileId
	FROM   [Weigh].[tblRemittance_Header] as r
	left join com.tblAshkhas ash on ash.fldid=fldEmployId
	left join com.tblEmployee as em on em.fldId=ash.fldHaghighiId/*فقط حقیقی ها بیان برای تحویل گیرنده */
	cross apply (select stuff((select N'،'+k.fldName from Weigh.tblRemittance_Details as d
					inner join com.tblKala as k on k.fldId=d.fldKalaId
					where d.fldRemittanceId=r.fldId for xml path('') ),1,1,'') as fldKalaName) as d

	outer apply (select e.fldFamily+' '+e.fldName as fldFamilyName,e.fldCodemeli,N'حقیقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblEmployee e on e.fldid=a.fldHaghighiId
					where a.fldid=r.fldAshkhasiId
				union all
				select h.fldName fldFamilyName,fldShenaseMelli fldCodemeli,N'حقوقی' fldTypeShakhs 
					from com.tblAshkhas a
					inner join com.tblAshkhaseHoghoghi h on h.fldid=a.fldHoghoghiId
					where a.fldid=r.fldAshkhasiId
				)Ashkahs

	outer apply (select c.fldTitle as fldNameChart from com.tblChartOrganEjraee  c
					where c.fldid=fldChartOrganEjraeeId
				)Chart
	outer apply (select  max(flddate )d,fldRemittanceId from Weigh.tblVazn_Baskool where fldRemittanceId= r.fldid  group by fldRemittanceId)		vv		
					where fldEndDate like @Value
	--order by case when  isnull(ff.fldBaghimande,0)<=0 then '2015-01-01'  else r.flddate  end desc 
	order by  d desc




	COMMIT
GO
