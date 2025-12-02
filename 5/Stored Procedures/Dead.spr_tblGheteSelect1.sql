SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create  PROC [Dead].[spr_tblGheteSelect1] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@id int,
@organid int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	WHERE  g.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select top(1) cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	
	WHERE  g.fldDesc like @Value and g.fldorganid=@organid

	if (@FieldName='fldNameGhete')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select top(1)cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	WHERE  fldNameGhete like @Value and g.fldorganid=@organid

	if (@FieldName='fldVadiSalamId')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select top(1) cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid )amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	WHERE  fldVadiSalamId like @Value and g.fldorganid=@organid

	if (@FieldName='CheckVadiSalamId')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select top(1) cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	WHERE  fldVadiSalamId like @Value 

	if (@FieldName='')
	SELECT  top (@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select top(1) cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join dead.tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from dead.tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	where  g.fldorganid=@organid

	if (@FieldName='CheckNameGhete')
	SELECT top(@h) g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare
	WHERE  fldNameGhete like @Value


	if (@FieldName='GheteKhali')
	begin
	declare @t table (idghete int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldGheteId  
		from dead.tblGhete g 
		inner join dead.tblradif r on g.fldid=r.fldGheteId
		inner join dead.tblShomare s on r.fldid=fldRadifId
		inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
		--left join dead.tblGhabreAmanat a on s.fldid=a.fldShomareId
		where fldVadiSalamId=@value and v.fldOrganId=@organid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldGheteId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t
		select fldGheteId from (select fldGheteId,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat /*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/

		if (@id<>0)
		insert @t
		select fldGheteId from Dead.tblGhabreAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblGhabreAmanat.fldid=@id

	SELECT top(@h)* from(select  g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	inner join @t on idghete=g.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare)t
	group by [fldId], [fldVadiSalamId], [fldNameGhete], [fldUserId],[fldIP],[fldDesc], [fldDate] 
	,NameVadiSalam,fldorganid,ExistsRecored,CountRadif,CountShomare
	end

	if (@FieldName='GheteKhali_Motevafa')
	begin
	declare @t2 table (idghete int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldGheteId  
		from dead.tblGhete g 
		inner join dead.tblradif r on g.fldid=r.fldGheteId
		inner join dead.tblShomare s on r.fldid=fldRadifId
		inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
		--left join dead.tblGhabreAmanat a on s.fldid=a.fldShomareId
		where fldVadiSalamId=@value and v.fldOrganId=@organid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldGheteId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t2
		select fldGheteId from (select fldGheteId,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat /*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/

		if (@id<>0)
		insert @t2
		select fldGheteId from dead.tblMotevaffa 
		inner join  Dead.tblGhabreAmanat on fldGhabreAmanatId=tblGhabreAmanat.fldid
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblMotevaffa.fldid=@id

	SELECT top(@h)* from(select  g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	inner join @t2 on idghete=g.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare)t
	group by [fldId], [fldVadiSalamId], [fldNameGhete], [fldUserId],[fldIP],[fldDesc], [fldDate] 
	,NameVadiSalam,fldorganid,ExistsRecored,CountRadif,CountShomare
	end



	if (@FieldName='GheteKhali_Request')
	begin
	declare @t1 table (idghete int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldGheteId  
		from dead.tblGhete g 
		inner join dead.tblradif r on g.fldid=r.fldGheteId
		inner join dead.tblShomare s on r.fldid=fldRadifId
		inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
		--left join dead.tblGhabreAmanat a on s.fldid=a.fldShomareId
		where fldVadiSalamId=@value and v.fldOrganId=@organid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldGheteId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
		insert @t1
		select fldGheteId from (select fldGheteId,isnull(amanat.tedad,0)+isnull(request.tedad,0)tedad,fldTedadTabaghat from tabaghe
		outer apply (select count(*)tedad from  dead.tblGhabreAmanat  where  tabaghe.ShomareId=fldShomareId)amanat
		outer apply (select count (*) tedad from dead.tblRequestAmanat where fldShomareId=tabaghe.ShomareId
		and fldIsEbtal<>1 and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid) or 
		exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamCharkhe=0) ))request
		)t where tedad<fldTedadTabaghat /*and 
		( not exists(select * from   dead.tblGhabreAmanat where  tabaghe.ShomareId=fldShomareId and id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId))*/

		if (@id<>0)
		insert @t1
		select fldGheteId from Dead.tblRequestAmanat
		inner join Dead.tblShomare on fldShomareId=tblShomare.fldid
		inner join dead.tblRadif on fldRadifId=tblRadif.fldid
		where tblRequestAmanat.fldid=@id

	SELECT top(@h)* from(select  g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored 
	,radif.tedad as CountRadif,shomare.tedad as CountShomare
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	inner join @t1 on idghete=g.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare)t
	group by [fldId], [fldVadiSalamId], [fldNameGhete], [fldUserId],[fldIP],[fldDesc], [fldDate] 
	,NameVadiSalam,fldorganid,ExistsRecored,CountRadif,CountShomare
	end
	
	
	COMMIT
GO
