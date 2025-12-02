SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	/*SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid,1 as fldZamen
		,1 fldValidDate
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid*/

	declare @Date varchar(10)
	set @Date=dbo.Fn_AssembelyMiladiToShamsi(getdate())

	if (@FieldName='fldId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select  case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor



	WHERE  c.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  c.fldDesc like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMaliyat')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldSumMaliyat like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMablaghfactor')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
		outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldMablaghfactor like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldTedadFactor')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
		outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldTedadFactor like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldTitleBudje')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
		outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  Budje.fldTitle like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMablaghVariz')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldMablaghfactor like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldContractTypeId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldContractTypeId like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNaghshOrgan')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate

	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldNaghshOrgan like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldTarikh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldTarikh like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldShomare')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldShomare like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldSubject')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldSubject like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldTarikhEblagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldTarikhEblagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldShomareEblagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje	
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldShomareEblagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldAshkhasId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje	
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldAshkhasId like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMablagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje	
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldMablagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldStartDate')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldStartDate like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldEndDate')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldEndDate like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMandePardakhtNashode')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  fldMandePardakhtNashode like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNameTarfDovom')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  TarfDovom.fldName like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNaghshName')
	SELECT top(@h)* from (SELECT c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
				
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor
					
				)t
	WHERE  fldNaghshName like @Value and  t.fldOrganId=@organId


	if (@FieldName='fldTypeTitle')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	WHERE  t.fldTitle like @Value and  c.fldOrganId=@organId

	

		if (@FieldName='fldOrganId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor

	where c.fldOrganId=@organId


	if (@FieldName='')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor


	if (@FieldName='AllFactorTrue')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle,fldSuplyMaterialsType, CASE WHEN  fldSuplyMaterialsType = 1 THEN N'کارفرما' WHEN  fldSuplyMaterialsType = 2 THEN N'پیمانکار' END AS fldSuplyMaterialsType_Name
	,isnull(fldTarikhTamdid,'_')fldTarikhTamdid, isnull(case when valid =1 then 2 when valid=0 then 1 end,0) as fldZamen
	,case when (fldEndDate<@Date and fldTarikhTamdid>=@Date)or (fldEndDate>=@Date) then 1 else 0 end as fldValidDate
	,isnull(Budje.fldTitle,'') as fldTitleBudje,isnull(fldBudjeCodingId_Detail,0)fldBudjeCodingId_Detail
	,isnull(fldTedadFactor,0)fldTedadFactor,isnull(fldMablaghfactor,0)fldMablaghfactor,isnull(fldSumMaliyat,0)fldMaliyat,fldMablagh-isnull(fldMablaghfactor,0) as fldMablaghVariz
	FROM   [cntr].[tblContracts] c
	inner join cntr.tblContractType t on t.fldid=fldContractTypeId
	cross apply (
					select fldName+' '+fldFamily as fldName  from com.tblAshkhas a inner join com.tblEmployee e
					on e.fldid=fldHaghighiId 
					where a.fldid=c.fldAshkhasId
					union all
					select fldName from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h
				 	on  h.fldid=a.fldHoghoghiId
					where a.fldid=c.fldAshkhasId
				)TarfDovom
	outer apply (
				select max(ta.fldTarikhPayan)fldTarikhTamdid from Cntr.tblTamdid ta
				 where fldContractId=c.fldid
				 )tamdid

	outer apply(
				select max(fldIsvalid) valid from 
				(select case when t.fldTarikh>=@date then 1 else 0 end as fldIsvalid
					from Cntr.tblTazamin t
				where fldContractId=c.fldId)tazmin 
			)_tazmin
	outer apply (
				  select case when fldBudjeCodingId_Detail=0 then N'' else fldTitle end fldTitle,fldBudjeCodingId_Detail from  [cntr].tblContract_CodingBudje 
				  inner join bud.tblCodingBudje_Details dd on dd.fldCodeingBudjeId=fldBudjeCodingId_Detail
				  where fldContractId=c.fldid
				)Budje
	outer apply (
					select fldTedadFactor,sum(fldMablagh) as fldMablaghfactor
					,sum(fldMablaghMaliyat)fldSumMaliyat from cntr.tblContract_Factor
					inner join cntr.tblFactor f on f.fldid=fldFactorId
					inner join cntr.tblFactorDetail fd on f.fldid=fd.fldHeaderId
					cross apply (select count(fldFactorId)fldTedadFactor from cntr.tblContract_Factor where   fldContractId=c.fldid) t
					where fldContractId=c.fldid
					group by fldTedadFactor
				)factor
where /*c.fldid=@Value and*/ exists (select  * from cntr.tblContract_Factor c1  	where c1.fldContractId=c.fldid ) 
and not exists (select * from cntr.tblContract_Factor c1 inner join cntr.tblFactor f 
										on f.fldid=c1.fldFactorId 
										where c1.fldContractId=c.fldid and f.fldStatus<>1)
	COMMIT
GO
