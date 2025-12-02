SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMotevaffaSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldId=@Value and m.fldOrganId=@OrganId

	if (@FieldName='fldCauseOfDeathId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldCauseOfDeathId=@Value and m.fldOrganId=@OrganId
	order by fldid desc

	if (@FieldName='fldGhabreAmanatId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldGhabreAmanatId=@Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldMahalFotId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldMahalFotId=@Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldTarikhFot')
	SELECT top(@h)* from (SELECT m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  m.fldOrganId=@OrganId)t
	WHERE  [fldTarikhFot] like @Value 
		order by fldid desc

	
		if (@FieldName='fldTarikhDafn')
	SELECT top(@h)* from (SELECT  m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where  m.fldOrganId=@OrganId)t
	WHERE  [fldTarikhDafn] like @Value 
		order by fldid desc

	if (@FieldName='fldDesc')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  m.fldDesc like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldOrganId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='CheckCauseOfDeathId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldCauseOfDeathId=@Value
		order by fldid desc
	if (@FieldName='CheckGhabreAmanatId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldGhabreAmanatId=@Value
		order by fldid desc
	if (@FieldName='CheckMahalFotId')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	where fldMahalFotId=@Value
		order by fldid desc
	
	if (@FieldName='fldNameVadiSalam')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  v.fldName like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldCodeMotevafa')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  (fldCodemeli like @Value or fldCodeMoshakhase like @Value) and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldFamily')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  isnull(g1.fldfamily,e.fldFamily) like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldname')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE isnull( e.fldname,g1.fldname)like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	if (@FieldName='fldTypeNameMotevafa')
	SELECT top(@h) *  from (SELECT m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE   m.fldOrganId=@OrganId)t
	where fldTypeNameMotevafa like @Value
		order by fldid desc


	if (@FieldName='fldShomare')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldShomare like @Value and m.fldOrganId=@OrganId
		order by fldid desc

	if (@FieldName='fldNameRadif')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldNameRadif like @Value and m.fldOrganId=@OrganId
		order by fldid desc

	if (@FieldName='fldNameGhete')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldNameGhete like @Value and m.fldOrganId=@OrganId
		order by fldid desc
		if (@FieldName='fldShomareTabaghe')
	SELECT top(@h) m.[fldId], [fldCauseOfDeathId], [fldGhabreAmanatId]
	,isnull(g1.flddeathDate, format( [fldTarikhFot],'####/##/##'))fldTarikhFot, isnull(format([fldTarikhDafn],'####/##/##'),'')[fldTarikhDafn], m.[fldOrganId], m.[fldUserId],m. [fldDesc], m.[fldDate], m.[fldIP] 
	,fldMahalFotId,isnull(mf.fldNameMahal,'')fldNameMahal,isnull(c.fldReason,'')fldReason
	,isnull( e.fldname,g1.fldname)fldname,isnull(e.fldFamily,g1.fldfamily)fldFamily,isnull(s.fldShomare,'')fldShomare
	,isnull( ed.fldFatherName,g1.fldnamefather)fldFatherName,isnull( fldCodemeli,g1.fldMeliCode)fldCodemeli,
	isnull(fldSh_Shenasname,'')fldSh_Shenasname,isnull(fldCodeMoshakhase,'')fldCodeMoshakhase
	,g1.fldGheteId,fldRadifId,fldVadiSalamId,isnull(v.fldName,'') as fldNameVadiSalam,isnull(fldNameGhete,'')fldNameGhete
	,isnull(fldNameRadif,'')fldNameRadif,isnull(fldTabaghe, fldShomareTabaghe)fldTabaghe
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then N'حقیقی' else N'سایر' end,'') as fldTypeNameMotevafa
	,isnull(case when e.fldCodemeli is not null and fldCodemeli<>'' then 0 else 1 end,'') as fldTypeMotevafa,isnull(fldShomareId,0)fldShomareId
	,isnull(fldCodemeli , fldCodeMoshakhase) as fldCodeMotevafa
	FROM   [Dead].[tblMotevaffa]  m
	
	inner join dead.tblghabreAmanat g on g.fldid=fldGhabreAmanatId
	inner join dead.tblGhabrInfo g1 on g1.fldid=g.fldGhabrInfoId
	left join dead. tblCauseOfDeath c on c.fldid=m.fldCauseOfDeathId
	left join dead.tblmahalfot mf on mf.fldid=fldMahalFotId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join tblRadif ra on ra.fldid=fldRadifId
	left join tblGhete ge on ge.fldid=g1.fldGheteId
	left join tblVadiSalam v on v.fldid=fldVadiSalamId
	WHERE  fldShomareTabaghe like @Value and m.fldOrganId=@OrganId
		order by fldid desc
	COMMIT
GO
