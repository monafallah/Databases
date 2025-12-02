SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create  PROC [Dead].[spr_tblGhabreAmanatSelect1] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 
---فقط اونایی که از قبل امانت گرفته شدن بیان
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldId=@Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null


		if (@FieldName='fldNameGhete')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE fldNameGhete like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

		if (@FieldName='fldNameRadif')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE fldNameRadif like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

		if (@FieldName='fldNameVadiSalam')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE v.fldName  like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

		if (@FieldName='fldMeli_Moshakhase')
	SELECT top(@h)* from (select  g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldOrganId=@OrganId)t
	where fldMeli_Moshakhase like @value
	and fldTarikhRezerv is not null


		if (@FieldName='fldSh_Shenasname')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE fldSh_Shenasname  like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

		if (@FieldName='fldFatherName')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE fldFatherName  like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

	if (@FieldName='fldname')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE e.fldname  like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

	if (@FieldName='fldFamily')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE e.fldFamily  like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null


	if (@FieldName='fldShomareId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldShomareId=@Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

	if (@FieldName='fldEmployeeId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldEmployeeId=@Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null


	if (@FieldName='fldShomareTabaghe')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldShomareTabaghe=@Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

	if (@FieldName='fldShomare')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  s.fldShomare like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null

	if (@FieldName='fldDesc')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.fldDesc like @Value and g.fldOrganId=@OrganId
	and fldTarikhRezerv is not null
		

	if (@FieldName='')
		SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  g.fldOrganId=@OrganId and fldTarikhRezerv is not null


	if (@FieldName='fldOrganId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  g.fldOrganId=@OrganId and fldTarikhRezerv is not null


	if (@FieldName='checkShomareId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  fldShomareId=@Value-- and fldTarikhRezerv is not null
	
	if (@FieldName='checkCodemeli')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  fldCodemeli=@Value or (fldCodeMoshakhase=@Value and fldCodemeli is null)
	--and fldTarikhRezerv is not null

	if (@FieldName='CheckEmployeeId')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as nvarchar(10)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  g.fldEmployeeId=@Value --and fldTarikhRezerv is not null


	if (@FieldName='CheckGhabrPor')
	SELECT top(@h) g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],'####/##/##'),'')[fldTarikhRezerv],g. [fldUserId], g.[fldDesc], g.[fldDate], g.[fldIP] 
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif
	,isnull(cast(fldShomareTabaghe as varchar(1)),N'قبر امانت') Tabaghe,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  g.[fldId] in (select  gh.fldid  from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join dead.tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=@value) and g.fldOrganId=@OrganId 
	--and fldTarikhRezerv is not null


	COMMIT
GO
