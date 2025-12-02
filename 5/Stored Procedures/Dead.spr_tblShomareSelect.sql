SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblShomareSelect] 
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
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  s.fldId=@Value and s.fldorganid=@fldOrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  s.fldDesc like @Value and s.fldorganid=@fldOrganId

	if (@FieldName='fldShomare')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  fldShomare like @Value and s.fldorganid=@fldOrganId

	if (@FieldName='fldRadifId')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  fldRadifId like @Value and s.fldorganid=@fldOrganId

	if (@FieldName='CheckRadifId')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  fldRadifId like @Value 

	if (@FieldName='ChekhShomare')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	WHERE  fldShomare like @Value

	if (@FieldName='')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	where s.fldorganid=@fldOrganId

		if (@FieldName='fldOrganId')
	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	where s.fldorganid=@fldOrganId


	if (@FieldName='ShomareKhali')
	begin 
	
	declare @t table (ShomareId int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId
		from 
		 dead.tblShomare s 
		where fldRadifId=@value and s.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		
		insert @t
			select shomareid  from (select shomareid,fldTedadTabaghat,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		group by shomareid,fldTedadTabaghat,request.tedad,amanat.tedad)t
		where tedad<fldTedadTabaghat
		--where (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat 
		/*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t
		select fldShomareId from Dead.tblGhabreAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblGhabreAmanat.fldid=@id

	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	inner join @t on ShomareId=s.fldid
	group by  s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId

	end

	if (@FieldName='ShomareKhali_Motevafa')
	begin 
	
	declare @t4 table (ShomareId int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId
		from 
		 dead.tblShomare s 
		where fldRadifId=@value and s.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		
		insert @t4
			select shomareid  from (select shomareid,fldTedadTabaghat,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		group by shomareid,fldTedadTabaghat,request.tedad,amanat.tedad)t
		where tedad<fldTedadTabaghat
		--where (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat 
		/*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t4
		select fldShomareId  from dead.tblMotevaffa 
		inner join  Dead.tblGhabreAmanat on fldGhabreAmanatId=tblGhabreAmanat.fldid
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblMotevaffa.fldid=@id

	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	inner join @t4 on ShomareId=s.fldid
	group by  s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId

	end


	if (@FieldName='ShomareKhali_Request')
	begin 
	
	declare @t1 table (ShomareId int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId
		from 
		 dead.tblShomare s 
		where fldRadifId=@value and s.fldOrganId=@fldorganid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		
		insert @t1
		select ShomareId from ( select ShomareId  ,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		group by shomareid,fldTedadTabaghat,request.tedad,amanat.tedad )t where tedad<fldTedadTabaghat
		--where (select count(*) from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId )<fldTedadTabaghat 
		/*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/
		
		if (@id<>0)
		insert @t1
		select fldShomareId from Dead.tblRequestAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblRequestAmanat.fldid=@id

	SELECT top(@h) s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId
	FROM   [Dead].[tblShomare] s inner join dead.tblRadif r
	on r.fldid=s.fldRadifId
	inner join @t1 on ShomareId=s.fldid
	group by  s.[fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], s.[fldUserId], s.[fldIp], s.[fldDesc], s.[fldDate] 
	,r.fldNameRadif,s.fldOrganId

	end
	
	COMMIT
GO
