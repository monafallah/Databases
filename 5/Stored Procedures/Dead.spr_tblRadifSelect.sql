SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRadifSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@id int,
@fldOrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  r.fldId=@Value and r.fldOrganId=@fldOrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  r.fldDesc like @Value and r.fldOrganId=@fldOrganId

		if (@FieldName='fldNameRadif')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  fldNameRadif like @Value and r.fldOrganId=@fldOrganId

	if (@FieldName='fldGheteId')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  fldGheteId like @Value and r.fldOrganId=@fldOrganId

	if (@FieldName='CheckGheteId')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  fldGheteId like @Value 

	if (@FieldName='CheckNameRadif')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	WHERE  fldNameRadif like @Value 

	if (@FieldName='')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	where r.fldOrganId=@fldOrganId


	if (@FieldName='fldOrganId')
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif],r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	where r.fldOrganId=@fldOrganId

	if (@FieldName='RadifKhali')
	begin
	declare @t table (idradif int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldRadifId  
		from  dead.tblradif r 
		inner join dead.tblShomare s on r.fldid=fldRadifId
		where fldGheteId=@value and r.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldRadifId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t
		select fldRadifId from (select fldRadifId ,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat
		--where  (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat /*and 
		/*( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t
		select fldRadifId from Dead.tblGhabreAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblGhabreAmanat.fldid=@id
	
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	inner join @t on idradif=r.fldid
	group by  r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	end

	if (@FieldName='RadifKhali_Motevafa')
	begin
	declare @t3 table (idradif int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldRadifId  
		from  dead.tblradif r 
		inner join dead.tblShomare s on r.fldid=fldRadifId
		where fldGheteId=@value and r.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldRadifId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t3
		select fldRadifId from (select fldRadifId ,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat
		--where  (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat /*and 
		/*( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t3
		select fldRadifId  from dead.tblMotevaffa 
		inner join  Dead.tblGhabreAmanat on fldGhabreAmanatId=tblGhabreAmanat.fldid
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblMotevaffa.fldid=@id
	
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	inner join @t3 on idradif=r.fldid
	group by  r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	end


	if (@FieldName='RadifKhali_Request')
	begin
	declare @t1 table (idradif int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldRadifId  
		from  dead.tblradif r 
		inner join dead.tblShomare s on r.fldid=fldRadifId
		where fldGheteId=@value and r.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldRadifId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t1
		select fldRadifId from (select fldRadifId ,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat
		--where  (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat /*and 
		/*( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t1
		select fldRadifId from Dead.tblRequestAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblRequestAmanat.fldid=@id
	
	SELECT top(@h) r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	FROM   [Dead].[tblRadif] r inner join dead.tblGhete g 
	on g.fldid=r.fldGheteId 
	inner join @t1 on idradif=r.fldid
	group by  r.[fldId], [fldGheteId], [fldNameRadif], r.[fldUserId], r.[fldIP], r.[fldDesc], r.[fldDate] 
	,fldNameGhete,r.fldOrganId
	end

	
	COMMIT
GO
