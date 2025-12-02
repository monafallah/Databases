SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Dead].[spr_tblMotevaffaSelect1] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldId=@Value and m.fldOrganId=@OrganId

	if (@FieldName='fldCauseOfDeathId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldCauseOfDeathId=@Value and m.fldOrganId=@OrganId
	order by fldid desc

	if (@FieldName='fldGhabreAmanatId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldGhabreAmanatId=@Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldMahalFotId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldMahalFotId=@Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldTarikhFot')
	SELECT top(@h)* from (select  m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  m.fldOrganId=@OrganId)t
	WHERE  [fldTarikhFot] like @Value 
		order by fldid desc

	
		if (@FieldName='fldTarikhDafn')
	SELECT top(@h)* from (select  m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  m.fldOrganId=@OrganId)t
	WHERE  [fldTarikhDafn] like @Value 
		order by fldid desc

	if (@FieldName='fldDesc')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldDesc like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldOrganId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='CheckCauseOfDeathId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldCauseOfDeathId=@Value
		order by fldid desc
	if (@FieldName='CheckGhabreAmanatId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldGhabreAmanatId=@Value
		order by fldid desc
	if (@FieldName='CheckMahalFotId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldMahalFotId=@Value
		order by fldid desc
	
	if (@FieldName='fldNameVadiSalam')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  v.fldName like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldCodeMotevafa')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  (fldCodemeli like @Value or fldCodeMoshakhase like @Value) and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldFamily')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldFamily like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldname')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  e.fldname like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldTypeNameMotevafa')
	SELECT top(@h) *  from (select m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE   m.fldOrganId=@OrganId)t
	where fldTypeNameMotevafa like @Value
		order by fldid desc


	if (@FieldName='fldShomare')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldShomare like @Value and m.fldOrganId=@OrganId
		order by fldid desc

	if (@FieldName='fldNameRadif')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldNameRadif like @Value and m.fldOrganId=@OrganId
		order by fldid desc

	if (@FieldName='fldNameGhete')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldNameGhete like @Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldShomareTabaghe')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId],format( [fldTarikhFot],'####/##/##')fldTarikhFot, format([fldTarikhDafn],'####/##/##')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,mf.fldNameMahal,c.fldReason
	,e.fldname,e.fldFamily,s.fldShomare,ed.fldFatherName,fldCodemeli,fldSh_Shenasname,fldCodeMoshakhase
	,fldGheteId,fldRadifId,fldVadiSalamId,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomareTabaghe
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end as fldTypeNameMotevafa
	,case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end as fldTypeMotevafa,fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	inner join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	inner join dead.tblShomare s on s.fldid=fldShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join tblRadif ra on ra.fldid=fldRadifId
	inner join tblGhete ge on ge.fldid=fldGheteId
	inner join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldShomareTabaghe like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	COMMIT
GO
