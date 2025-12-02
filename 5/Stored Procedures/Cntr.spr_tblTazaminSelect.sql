SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTazaminSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  t.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  t.fldDesc like @Value and t.fldorganId=@organId


	if (@FieldName='fldOrganId')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE   t.fldorganId=@organId


	if (@FieldName='fldSubject')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  fldSubject like @Value and t.fldorganId=@organId


	if (@FieldName='fldContractId')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  fldContractId like @Value and t.fldorganId=@organId


	if (@FieldName='fldWarrantyTypeId')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  fldWarrantyTypeId like @Value and t.fldorganId=@organId

	if (@FieldName='fldTypeTamdid')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  fldTypeTamdid like @Value and t.fldorganId=@organId

		if (@FieldName='fldTypeTamdidName')
	SELECT top(@h) * from (select t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId)t
	WHERE  fldTypeTamdidName like @Value and t.fldorganId=@organId


		if (@FieldName='fldNameWarranty')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  w.fldName like @Value and t.fldorganId=@organId


		if (@FieldName='fldMablagh')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  t.fldMablagh like @Value and t.fldorganId=@organId


	if (@FieldName='fldSepamNum')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  t.fldSepamNum like @Value and t.fldorganId=@organId

		if (@FieldName='fldTarikh')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId
	WHERE  t.fldTarikh like @Value and t.fldorganId=@organId





	if (@FieldName='')
	SELECT top(@h) t.[fldId], [fldContractId], [fldWarrantyTypeId], [fldTypeTamdid], [fldSepamNum], t.[fldTarikh], t.[fldMablagh], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,case when fldTypeTamdid=1 then  N'تمدید' else N'اصلی' end as fldTypeTamdidName
	,fldSubject,w.fldName as fldNameWarranty
	,case when t.fldTarikh>=dbo.Fn_AssembelyMiladiToShamsi(getdate())then 1 else 0 end as fldIsvalid
	FROM   [Cntr].[tblTazamin] t
	inner join com.tblWarrantyType w on w.fldid=t.fldWarrantyTypeId
	inner join [cntr].[tblContracts] c on c.fldid=fldContractId

	
	COMMIT
GO
