SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[cntr.[spr_tblContractsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  c.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  c.fldDesc like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldContractTypeId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldContractTypeId like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNaghshOrgan')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldNaghshOrgan like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldTarikh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldTarikh like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldShomare')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldShomare like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldSubject')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldSubject like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldTarikhEblagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldTarikhEblagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldShomareEblagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldShomareEblagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldAshkhasId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldAshkhasId like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMablagh')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldMablagh like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldStartDate')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldStartDate like @Value and  c.fldOrganId=@organId


	if (@FieldName='fldEndDate')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldEndDate like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldMandePardakhtNashode')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  fldMandePardakhtNashode like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNameTarfDovom')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  TarfDovom.fldName like @Value and  c.fldOrganId=@organId

	if (@FieldName='fldNaghshName')
	SELECT top(@h)* from (select  c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
				)t
	WHERE  fldNaghshName like @Value and  t.fldOrganId=@organId


	if (@FieldName='fldTypeTitle')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	WHERE  t.fldTitle like @Value and  c.fldOrganId=@organId

	

		if (@FieldName='fldOrganId')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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
	where c.fldOrganId=@organId


	if (@FieldName='')
	SELECT top(@h) c.[fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh], [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], c.[fldUserId], c.[fldOrganId],c. [fldIP], c.[fldDesc], c.[fldDate] 
	,TarfDovom.fldName as fldNameTarfDovom,case when fldNaghshOrgan=0 then N'کارفرما' else N'پیمانکار' end as fldNaghshName
	,t.fldTitle As fldTypeTitle
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

	
	COMMIT
GO
