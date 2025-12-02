SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTamdidSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldId=@Value

	if (@FieldName='fldDesc')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldDesc like @Value and t.fldOrganId=@organId

	if (@FieldName='fldOrganId')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldOrganId=@organId

	if (@FieldName='fldTypeTamdidName')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  ty.fldTitle like @Value and t.fldOrganId=@organId

	if (@FieldName='fldContractId')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldContractId like @Value and t.fldOrganId=@organId

	if (@FieldName='fldTamdidTypeId')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldTamdidTypeId like @Value and t.fldOrganId=@organId

	if (@FieldName='fldTarikhPayan')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldTarikhPayan like @Value and t.fldOrganId=@organId
	
	if (@FieldName='fldMablaghAfzayeshi')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldMablaghAfzayeshi like @Value and t.fldOrganId=@organId

	if (@FieldName='fldSubject')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId 
	WHERE  t.fldTarikhPayan like @Value and t.fldOrganId=@organId

	if (@FieldName='')
		SELECT top(@h) t.[fldId], [fldContractId], [fldTamdidTypeId], [fldTarikhPayan], [fldMablaghAfzayeshi], t.[fldUserId], t.[fldOrganId], t.[fldIP], t.[fldDesc], t.[fldDate] 
	,c.fldSubject,ty.fldTitle as fldTypeTamdidName
	FROM   [Cntr].[tblTamdid] t
	inner join cntr.tblContracts c on c.fldid=t.fldContractId
	inner join Cntr.tblTamdidTypes ty on ty.fldid=fldTamdidTypeId  


	
	COMMIT
GO
