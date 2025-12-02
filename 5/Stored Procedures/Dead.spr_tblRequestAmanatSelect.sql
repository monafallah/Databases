SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRequestAmanatSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  r.fldId=@Value and r.fldOrganId = @OrganId

	if (@FieldName='fldSh_Shenasname')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  fldSh_Shenasname like @Value and r.fldOrganId = @OrganId

	if (@FieldName='fldName')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  e.fldName like @Value and r.fldOrganId = @OrganId


	if (@FieldName='fldFamily')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  e.fldFamily like @Value and r.fldOrganId = @OrganId

	if (@FieldName='fldFatherName')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  fldFatherName like @Value and r.fldOrganId = @OrganId

		if (@FieldName='fldMeli_Moshakhase')
	SELECT top(@h)* from (select r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE    r.fldOrganId = @OrganId)t
	where fldMeli_Moshakhase like @value 

		if (@FieldName='fldShomare')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE fldShomare like @Value and r.fldOrganId = @OrganId


		if (@FieldName='fldNameRadif')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE fldNameRadif like @Value and r.fldOrganId = @OrganId


		if (@FieldName='fldNameGhete')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  fldNameGhete like @Value and r.fldOrganId = @OrganId



		if (@FieldName='fldNameVadiSalam')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  v.fldName like @Value and r.fldOrganId = @OrganId


	if (@FieldName='fldEmployeeId')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
	,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1 and fldOrganId=@OrganId)kartabl
	WHERE  r.fldEmployeeId=@Value and r.fldOrganId = @OrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe, isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.fldDesc like @Value and r.fldOrganId = @OrganId


	if (@FieldName='NotExistsAmanat')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
	,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1)  cast(1 as bit) ExistsCharkhe, isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  not exists (select * from dead.tblGhabreAmanat ga where r.fldShomareId=ga.fldid and ga.fldOrganId=@OrganId) and  r.fldOrganId = @OrganId


	if (@FieldName='fldOrganId')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe, isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.fldOrganId = @OrganId

	if (@FieldName='')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe, isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request

	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.fldOrganId = @OrganId

	if (@FieldName='CheckEmployeeId')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe, isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request
	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.fldEmployeeId = @Value

	if (@FieldName='CheckShomareId')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,  isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request

	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.fldShomareId = @Value


	if (@FieldName='CheckGhabrPor')
	SELECT top(@h) r.[fldId], r.[fldEmployeeId], r.[fldShomareId], r.[fldOrganId], r.[fldUserId],r.[fldIP], r.[fldDesc],r.[fldDate] 
	,e.fldName,fldFamily,fldSh_Shenasname,fldFatherName ,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,v.fldName as fldNameVadiSalam,fldNameGhete,fldNameRadif,fldShomare,format(r.fldTarikh,'####/##/##')fldTarikhRequest
		,isnull(kartabl_request.fldTitleKartabl,kartabl.fldTitleKartabl)fldTitleKartabl,isnull(kartabl_request.fldKartablId,kartabl.fldKartablId)fldKartablId
,isnull(ExistsCharkhe,cast(0 as bit))ExistsCharkhe,fldGheteId,fldRadifId,v.fldid as fldVadiSalamId
	,fldCodemeli,fldCodeMoshakhase,fldIsEbtal,case when fldIsEbtal =1 then N'ابطال شده' else N'ابطال نشده' end as fldIsEbtalName
	FROM   [Dead].[tblRequestAmanat] r 
	inner join com.tblEmployee e on fldEmployeeId=e.fldId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	inner join dead.tblShomare s on s.fldId=fldShomareId
	inner join dead.tblradif ra on ra.fldid=fldRadifId
	inner join dead.tblGhete g on g.fldid=fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=g.fldVadiSalamId
	outer apply (select top(1) cast(1 as bit) ExistsCharkhe,  isnull(fldTitleKartabl,'')fldTitleKartabl,isnull(fldkartablNextId,0)fldKartablId from dead.tblKartabl_Request k left join dead.tblkartabl
	on fldkartablNextId=tblkartabl.fldid where fldRequestId=r.fldid order by  k.fldid desc)kartabl_request

	outer apply (select fldTitleKartabl,fldid fldKartablId from dead.tblKartabl where fldOrderId=1  and fldOrganId=@OrganId)kartabl

	WHERE  r.[fldId] in (select  r1.fldid  from dead.tblradif r 
	inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join dead.tblRequestAmanat r1 on s.fldid=fldShomareId
	where fldGheteId=@value) and g.fldOrganId=@OrganId 
	and fldIsEbtal<>1 and (not exists (select  *from dead.tblkartabl_request where fldRequestId=r.fldid)
	or exists (select * from dead.tblkartabl_request where fldRequestId=r.fldid and fldEtmamCharkhe<>1))
	
	COMMIT
GO
