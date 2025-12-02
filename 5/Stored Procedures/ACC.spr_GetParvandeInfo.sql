SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_GetParvandeInfo]
 @fieldname nvarchar(50),
 @Value nvarchar(50),
 @ParvandeType int,
 @Year smallint,
 @organId int,
 @h int
 as
 begin tran
 if (@h=0) set @h=2147483647

if(@ParvandeType=1)/*حقیقی*/
begin
	if (@fieldname=N'fldId')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblEmployee
	where tblEmployee.fldId like @Value

	if (@fieldname=N'fldName')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblEmployee
	where fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' like @Value

	if (@fieldname=N'fldCodemeli')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblEmployee inner join
	com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldId
	where tblEmployee.fldCodemeli like @Value

	if (@fieldname=N'')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblEmployee inner join
	com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldId
end
else if(@ParvandeType=2)/*حقوقی*/
begin
	if (@fieldname=N'fldId')
	select top(@h)  N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblAshkhaseHoghoghi
	where fldId like @Value

	if (@fieldname=N'fldName')
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblAshkhaseHoghoghi
	where fldName+'('+fldShenaseMelli+')'  like @Value

	if (@fieldname=N'fldCodemeli')
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	 from com.tblAshkhaseHoghoghi
	where fldShenaseMelli like @Value

	if (@fieldname=N'')
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from com.tblAshkhaseHoghoghi
end
else if(@ParvandeType in (13,14))/*قرارداد وارده و صادره*/
begin
	if (@fieldname=N'fldId')
	select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldId like @Value and fldOrganId=@organId

	if (@fieldname=N'fldName')
	select top(@h) * from(	select    N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where  fldOrganId=@organId)t
	where fldName like @Value 

	if (@fieldname=N'fldStartContract')
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldStartDate like @Value and fldOrganId=@organId


	if (@fieldname=N'fldEndContract')
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldEndDate like @Value and fldOrganId=@organId
	 
	if (@fieldname=N'')
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where  fldOrganId=@organId
end

else if (@ParvandeType=12)
begin
	if (@fieldname=N'fldId')
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور شماره'+' '+fldShomare  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldId like @Value  and fldOrganId=@organId

	if (@fieldname=N'fldName')
	select top(@h) * from ( select N'فاکتور صادره' as fldType,fldId,N'فاکتور شماره'+' '+fldShomare  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where  fldOrganId=@organId)t where fldName like @Value  



	if (@fieldname=N'fldCodemeli')
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور شماره'+' '+fldShomare  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldShomare like @Value  and fldOrganId=@organId


	if (@fieldname=N'fldEndContract')
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور شماره'+' '+fldShomare  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldTarikh like @Value  and fldOrganId=@organId


	if (@fieldname=N'fldMablagh')
	select top(@h) * from (select  N'فاکتور صادره' as fldType,fldId,N'فاکتور شماره'+' '+fldShomare  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where  fldOrganId=@organId ) t where fldMablagh like @Value  


end

else if(@ParvandeType=3)/*چک وارده*/
begin
	if (@fieldname=N'fldId')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldId like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null فعلن امکان ثبت چک از درآمد هست

	if (@fieldname=N'fldName')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldBabat+'('+fldShomareSanad+')' like @Value and fldOrganId=@organId --and fldReplyTaghsitId is null

	if (@fieldname=N'fldStartContract')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldTarikhAkhz like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null

	if (@fieldname=N'fldEndContract')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldTarikhSarResid like @Value and fldOrganId=@organId --and fldReplyTaghsitId is null

	if (@fieldname=N'fldCodemeli')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldShomareSanad like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null

	if (@fieldname=N'fldMablagh')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck
	where fldMablaghSanad like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null

	if (@fieldname=N'')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')' fldName,fldShomareSanad  fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,@ParvandeType as fldTypeId
	from drd.tblCheck 
	where  fldOrganId=@organId  --and fldReplyTaghsitId is null
end

else if(@ParvandeType=4)/*چک صادره*/
begin
	if (@fieldname=N'fldId')
	select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldId like @Value  and fldOrganId=@organId

	if (@fieldname=N'fldName')
	select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldBabat+'('+fldCodeSerialCheck+')' like @Value  and fldOrganId=@organId

	if (@fieldname=N'fldStartContract')
		select top(@h)* from (select   N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where   fldOrganId=@organId
	)t
	where fldStartContract=@Value

	if (@fieldname=N'fldEndContract')
		select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldTarikhVosol like @Value and    fldOrganId=@organId

	if (@fieldname=N'fldMablagh')
		select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldMablagh like @Value and fldOrganId=@organId

	if (@fieldname=N'fldCodemeli')
		select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldCodeSerialCheck like @Value and fldOrganId=@organId

	if (@fieldname=N'')
		select top(@h)  N'چک صادره' as fldType,fldId,'چک به شماره سریال '+fldCodeSerialCheck+'('+fldBabat+')' fldName,fldCodeSerialCheck fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from chk.tblSodorCheck
	where fldOrganId=@organId
end

else if(@ParvandeType=6)/*فیش درآمد*/
begin
	if (@fieldname=N'fldId')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid 
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez
	where s.fldId like @Value  and e.fldOrganId=@organId  and ebtal.isebtal is null 

	if (@fieldname=N'fldName')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldName like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'fldCodemeli')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldCodemeli like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 



	if (@fieldname=N'fldStartContract')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where s.fldTarikh  like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'fldEndContract')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where e.fldTarikh  like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 



	if (@fieldname=N'fldMablagh')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldMablaghAvarezGerdShode like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'fldShenasePardakht')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShenasePardakht like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 



	if (@fieldname=N'fldShenaseGhabz')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShenaseGhabz like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'fldShomareHesab')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShomareHesab like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'fldIsEbtal')
	select top(@h)  * from (select N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldOrganId=@organId and ebtal.isebtal is null )t where fldIsEbtal like @Value   

	if (@fieldname=N'fldSharh')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldSharh like @Value  and e.fldOrganId=@organId and ebtal.isebtal is null 


	if (@fieldname=N'')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,@ParvandeType as fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				where   e.fldOrganId=@organId and ebtal.isebtal is null 
				
				
end

else if(@ParvandeType=15)/*پروژه ها*/
begin
	if (@fieldname=N'fldId')
	select  top(@h)  N'پروژه' as fldType,N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 	
	and  pf.fldCodeingBudjeId like @Value 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)

	if (@fieldname=N'fldName')
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and  pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')'  like @Value  
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)

	if (@fieldname=N'fldCodemeli')
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and  pf.fldCode like @Value   
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)

	if (@fieldname=N'fldStartContract')
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where  h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and  h.fldYear like @Value  
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId) 

	if (@fieldname=N'fldSharh')
	select top(@h)  * from (select  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	  )t
	where fldSharh like @Value   


	if (@fieldname=N'')
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,@ParvandeType as fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	 
	
end

else if(@ParvandeType=5)/*شماره حساب*/
begin
	if (@fieldname=N'fldId')
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' collate Persian_100_CI_AI*/ s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' fldName
	,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where s.fldid=@value and  o.fldid=@organId

	if (@fieldname=N'fldName')
	select top(@h) * from(select N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' collate Persian_100_CI_AI*/ s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId )t where fldName like @value

	if (@fieldname=N'fldCodemeli')
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')'  collate Persian_100_CI_AI */s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId and h.fldShenaseMelli like @value 


	if (@fieldname=N'fldShomareHesab')
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' collate Persian_100_CI_AI*/ s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId and s.fldShomareHesab like @value 


	if (@fieldname=N'fldSharh')
	select top(@h) * from (
	select  N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' collate Persian_100_CI_AI*/ s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId)t
	where  fldSharh like @value  

	if (@fieldname=N'')
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+h.fldShenaseMelli+')' collate Persian_100_CI_AI*/ s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,@ParvandeType as fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId 
end
if(@ParvandeType=0)
begin
	if (@fieldname=N'fldId')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,1 fldTypeId
	from com.tblEmployee
	where tblEmployee.fldId like @Value
	union 
	select top(@h)  N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,2 fldTypeId
	from com.tblAshkhaseHoghoghi
	where fldId like @Value
	union 
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldId like @Value and fldOrganId=@organId
	union
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldId like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null
	union 
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where fldId like @Value  and fldOrganId=@organId
	union 
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh, 6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+fldFatherName+'_'+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					INNER JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid 
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez
	where s.fldId like @Value  and e.fldOrganId=@organId  and ebtal.isebtal is null 
	union
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and pf.fldCodeingBudjeId like @Value  
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	union
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName+'_'+s.fldShomareHesab+')'*/s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where s.fldid=@value and  o.fldid=@organId
	union all
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	, fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldId like @Value  and fldOrganId=@organId
 
	if (@fieldname=N'fldName')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,1 fldTypeId
	from com.tblEmployee 
	where fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' like @Value
	union 
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,2 fldTypeId
	from com.tblAshkhaseHoghoghi
	where fldName+'('+fldShenaseMelli+')'  like @Value
	union 
	select top(@h) * from ( 	select   N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where  fldOrganId=@organId)t
	where fldName  like @Value
	union
	select top(@h)* from (select   N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldOrganId=@organId /*and  fldReplyTaghsitId is null*/)t
	where fldName like @Value  
	union 
	select top(@h) * from (select  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where  fldOrganId=@organId)t
	where fldName like @Value  
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+fldFatherName+'_'+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					INNER JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldName like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')'  like @Value  
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId) 
	union
	select top(@h) *from (select N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')'*/s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'   fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId 

	union all
	select top(@h)   N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where  fldOrganId=@organId
	)t
	where fldname like @value

	if (@fieldname=N'fldCodemeli')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName +'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,1 fldTypeId
	from com.tblEmployee 
	where tblEmployee.fldCodemeli like @Value
	union 
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,2 fldTypeId
	 from com.tblAshkhaseHoghoghi
	where fldShenaseMelli like @Value
	union 
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldShomareSanad like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null
	union
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where fldCodeSerialCheck like @Value  and fldOrganId=@organId
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldCodemeli like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	and pf.fldCode like @Value   
	union
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')' */s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId and h.fldShenaseMelli like @value
	
	union all
	
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldShomare like @Value  and fldOrganId=@organId

 

	if (@fieldname=N'fldStartContract')
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldStartDate like @Value and fldOrganId=@organId
	union
	select top(@h) * from (select  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldOrganId=@organId /*and  fldReplyTaghsitId is null*/)t
	where fldStartContract like @value
	union
	select top(@h) * from (select  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where  fldOrganId=@organId)t
	where fldStartContract like @Value  
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName   +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where s.fldTarikh  like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union
	select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where  h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and h.fldYear like @Value   
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	
	if (@fieldname=N'fldEndContract')
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where fldEndDate like @Value and fldOrganId=@organId
	union
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldTarikhSarResid like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null
	union
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where fldTarikhVosol like @Value  and fldOrganId=@organId
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName   +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
	
				
	where e.fldTarikh  like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union all
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldTarikh like @Value  and fldOrganId=@organId

	if (@fieldname=N'fldMablagh')
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldMablaghSanad like @Value and fldOrganId=@organId --and  fldReplyTaghsitId is null
	union
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where fldMablagh like @Value  and fldOrganId=@organId
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName   +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldMablaghAvarezGerdShode like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	 union all
	 select top(@h) * from (select  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where  fldOrganId=@organId ) t where fldMablagh like @Value  

	if (@fieldname=N'')
	select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,1 fldTypeId
	from com.tblEmployee 
	union 
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,2 fldTypeId
	from com.tblAshkhaseHoghoghi
	union 
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where  fldOrganId=@organId
	union 
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where fldOrganId=@organId --and  fldReplyTaghsitId is null
	union
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where fldOrganId=@organId
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+fldFatherName+'_'+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					INNER JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				where   e.fldOrganId=@organId and ebtal.isebtal is null 
union
select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	union
	select top(@h) N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')'*/s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'   fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId 
union all

	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where  fldOrganId=@organId


	if (@fieldname=N'fldType')
	select * from (select top(@h) N'شخص حقیقی' as fldType,tblEmployee.fldId,fldName+'_'+fldFamily+'('+fldFatherName+'_'+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName ,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh 
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,1 fldTypeId
	from com.tblEmployee inner join
	com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldId
	union 
	select top(@h)   N'شخص حقوقی' as fldType,fldId,fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli fldCodemeli,''fldStartContract,''fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,2 fldTypeId
	from com.tblAshkhaseHoghoghi
	union 
		select top(@h)  N'قرارداد ها' as fldType,fldId,N'قرارداد به شماره'+c.fldShomare+'('+TarfDovom.fldName+')' collate Persian_100_CI_AI fldName,'' fldCodemeli,fldStartDate fldStartContract, fldEndDate fldEndContract,cast(0 as bigint)fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from Cntr.tblContracts c
		cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	where  fldOrganId=@organId
	union 
	select top(@h)  N'چک وارده' as fldType,fldId,fldBabat+'('+fldShomareSanad+')'  COLLATE Persian_100_CI_AI fldName,fldShomareSanad  COLLATE Persian_100_CI_AI fldCodemeli, fldTarikhAkhz fldStartContract,fldTarikhSarResid fldEndContract,cast(fldMablaghSanad  as bigint) as fldMablagh
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,3 fldTypeId
	from  drd.tblCheck
	where  fldOrganId=@organId --and  fldReplyTaghsitId is null
	union
	select top(@h)  N'چک صادره' as fldType,fldId,fldBabat+'('+fldCodeSerialCheck+')' COLLATE Persian_100_CI_AI fldName,fldCodeSerialCheck  COLLATE Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldStartContract,fldTarikhVosol fldEndContract,fldMablagh fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh ,4 fldTypeId
	from chk.tblSodorCheck
	where  fldOrganId=@organId
	union
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+fldFatherName+'_'+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					INNER JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				where   e.fldOrganId=@organId and ebtal.isebtal is null 
union
select  top(@h)  N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId)
	union
	select top(@h) N'شماره حساب' as fldType,s.fldId,h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')'  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId 
	)t
	where fldType like @Value

	if (@fieldname=N'fldShenasePardakht')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShenasePardakht like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union all
	select top(@h)  N'فاکتور صادره' as fldType,fldId,N'فاکتور به شماره'+' '+cast(fldId as varchar(10))  fldName,fldShomare collate Persian_100_CI_AI fldCodemeli, dbo.Fn_AssembelyMiladiToShamsi(flddate) fldStartContract,fldTarikh fldEndContract,isnull(sumMablagh,0) fldMablagh  
	,fldShanaseMoadiyan fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,''fldSharh,@ParvandeType as fldTypeId
	from cntr.tblFactor
	cross apply (select sum(fldMablagh)+sum(fldMablaghMaliyat) sumMablagh from cntr.tblFactorDetail f where f.fldHeaderId=cntr.tblFactor.fldid) SumMablagh
	where fldShanaseMoadiyan like @Value  and fldOrganId=@organId




	if (@fieldname=N'fldShenaseGhabz')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  collate SQL_Latin1_General_CP1_CI_AS +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShenaseGhabz like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 

	if (@fieldname=N'fldShomareHesab')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName   +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldShomareHesab like @Value   and e.fldOrganId=@organId and ebtal.isebtal is null 
	union
	select top(@h) N'شماره حساب/*' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')'*/s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'   collate Persian_100_CI_AI  fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId and s.fldShomareHesab like @value

	if (@fieldname=N'fldIsEbtal')
	select top(@h)  * from (select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName  +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldOrganId=@organId and ebtal.isebtal is null )t where fldIsEbtal like @Value   

	if (@fieldname=N'fldSharh')
	select top(@h)N'درآمد' as fldType, s.fldId, fldName, fldCodemeli, s.fldTarikh fldStartContract,e.fldTarikh fldEndContract,fldMablaghAvarezGerdShode fldMablagh
	,s.fldShenasePardakht,s.fldShenaseGhabz,sh.fldShomareHesab,case when isebtal=1 then N'ابطال' else N'صدور' end as fldIsEbtal,fldSharh,6 fldTypeId
	 from drd.tblSodoorFish s
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId 
	inner join com.tblShomareHesabeOmoomi sh on sh.fldId=fldShomareHesabId
	cross apply (
					select fldName+' '+fldFamily+'('+isnull(fldFatherName   +'_','')+isnull(fldCodemeli,fldCodeMoshakhase)+')' as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli 
					from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					left JOIN com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
					where a.fldid=fldAshakhasID
					union all
					select fldName+'('+fldShenaseMelli+')' as fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	outer apply (
					select 1 isebtal from drd.tblEbtal 
					where fldFishId=s.fldid
				)ebtal
	cross apply (
					select stuff((select ','+c.fldSharheCodeDaramad from drd.tblCodhayeDaramadiElamAvarez c
					where c.fldElamAvarezId=e.fldid for xml path ('')),1,1,'')fldSharh
				)CodeElamAvarez	
				
	where fldSharh like @Value  and e.fldOrganId=@organId and ebtal.isebtal is null 
	union
	select  top(@h) * from (
	select   N'پروژه' as fldType,pf.fldCodeingBudjeId as fldId,pf.fldTitle+'('+pf.fldCode+'_'+cast(h.fldYear as varchar(4))+')' collate Persian_100_CI_AI fldName,pf.fldCode  collate Persian_100_CI_AI  fldCodemeli, cast(h.fldYear as varchar(4)) fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,''fldShomareHesab,'' fldIsEbtal,a.fldSharh collate Persian_100_CI_AI fldSharh,15 fldTypeId
	from bud.tblCodingBudje_Details pf
	inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=pf.fldHeaderId
	outer apply(select stuff((select '_'+d.fldTitle from bud.tblCodingBudje_Details as d where pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and pf.fldCodeingBudjeId<>d.fldCodeingBudjeId for xml path('')),1,1,'') as fldSharh) a
	where h.fldYear=@Year  and h.fldOrganId=@organId and pf.fldLevelId=4 and fldTarh_KhedmatTypeId=1 
	and exists (select *  from bud.tblPishbini as p where p.fldCodingBudje_DetailsId=pf.fldCodeingBudjeId) )t
	where fldSharh like @Value 
	union
	select top(@h) * from (
	select  N'شماره حساب' as fldType,s.fldId,/*h.fldName+'('+b.fldBankName  collate Persian_100_CI_AI+'_'+s.fldShomareHesab  collate Persian_100_CI_AI+')'*/s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'   fldName,h.fldShenaseMelli fldCodemeli, '' fldStartContract,'' fldEndContract,cast(0 as bigint) fldMablagh  
	,''fldShenasePardakht,''fldShenaseGhabz,s.fldShomareHesab fldShomareHesab,'' fldIsEbtal,b.fldBankName+'('+sh.fldName+')'  fldSharh,5 fldTypeId
	 from com.tblShomareHesabeOmoomi s
	inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	where o.fldid=@organId)t
	where  fldSharh like @value  
end
commit tran
GO
