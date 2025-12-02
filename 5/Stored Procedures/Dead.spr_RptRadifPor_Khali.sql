SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_RptRadifPor_Khali](@fieldName nvarchar(50),@vadiSalam varchar(10),@organ varchar(10),@GheteId varchar(20))
as
--declare @fieldName nvarchar(50)=N'nesfe',@vadiSalam varchar(10)='1',@organ varchar(10)=1,@GheteId varchar(20)='1'
--select 0 fldGheteId,0RadifId,''fldShomare,''fldNameRadif,'' NameGhete,0ShomareId,''fldNamevadiSalam,
--	''Name_Family,''Meli_Moshakhase,'' As FatherName,'' Sh_Sh,'' as TarikhFot,''As Tabaghe ,''TabagheKhali
declare @query nvarchar(max)='',@amant nvarchar(20)=N' امانت' ,@tabaghe nvarchar(10)=N'طبقه',@Rezerv nvarchar(20)=N'رزرو'
set @query='
;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId,fldGheteId 
		,r.fldid as radifid,fldShomare,fldNameRadif,fldNameGhete ,v.fldName as fldNamevadiSalam
		from dead.tblGhete g 
		inner join dead.tblradif r on g.fldid=r.fldGheteId
		inner join dead.tblShomare s on r.fldid=fldRadifId
		inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
		/*left join dead.tblGhabreAmanat a on s.fldid=a.fldShomareId*/
		where fldVadiSalamId='+@vadiSalam+ ' and v.fldOrganId='+@organ+'
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldGheteId,radifid,fldShomare,fldNameRadif,fldNameGhete,fldNamevadiSalam  from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)'

	if (@fieldname='Khali')
	begin
	set @query=@query+ ' select tabaghe.fldGheteId,RadifId,'''' fldShomare,fldNameRadif,fldNameGhete as NameGhete,0 ShomareId,fldNamevadiSalam,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,''''As Tabaghe 
	,''''TabagheKhali
	from tabaghe
	
	 outer apply (select 1 as id,fldRadifId  from dead.tblRequestAmanat
					inner join dead.tblshomare on fldShomareId=tblshomare.fldid
					
				 left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
				 where fldradifId=tabaghe.radifid and fldIsEbtal<>1 
				 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1) )
				 )requestpor
	where  not exists (select * from dead.tblGhabreAmanat inner join dead.tblshomare on fldShomareId=tblShomare.fldid
					 where fldradifId=tabaghe.radifid)
					and requestpor .id is null
	
	'
	 
	 if (@GheteId<>'0')
	 set @query=@query+ ' and tabaghe.fldGheteId='+@GheteId
	 
	
	 set @query=@query+ ' group by fldNameRadif,fldNameGhete,fldNamevadiSalam, tabaghe.fldGheteId,RadifId
						order by fldNameGhete' 
						
	end
	if (@fieldname='Por')
	begin
	set @query=@query+ 'select x. fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
	Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,sumkol,fldEmployeeId
	,Tabaghe,TabaghatKhali from (select q. fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
	Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,sumkol,fldEmployeeId
	,Tabaghe,TabaghatKhali  ,ISNULL(amanatpor.tedad,0)+isnull(requstpor.tedad,0) tedadporshode
	 from 
	(select tabaghe.fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(e.fldCodemeli,e.fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName
	,fldSh_Shenasname Sh_Sh,coalesce(format( [fldTarikhFot],''####/##/##''),amanat.title) as TarikhFot
	,coalesce(cast(fldShomareTabaghe  as nvarchar(20)),amanat.title)As Tabaghe
	,'''' TabaghatKhali,amanat.fldEmployeeId
	
	from tabaghe
		outer apply (select N'''+@amant+''' Title,* from dead .tblGhabreAmanat 
		where fldShomareId=tabaghe.ShomareId)amanat
	
	inner join Com.tblEmployee e on e.fldid=amanat.fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblMotevaffa m on fldGhabreAmanatId=amanat.fldid

	union all 
	select tabaghe.fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(e.fldCodemeli,e.fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName
	,fldSh_Shenasname Sh_Sh,request.title as TarikhFot
	,request.title As Tabaghe
	,'''' TabaghatKhali,request.fldEmployeeId
   from tabaghe
	outer apply (select N'''+@Rezerv+'''Title,* from
						(select tblRequestAmanat.fldid,fldshomareid ,fldEmployeeId  
						 from dead .tblRequestAmanat 
						left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
						where  fldShomareId=tabaghe.ShomareId and fldIsEbtal <>1 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1 ))
						group by tblRequestAmanat.fldid,fldshomareid ,fldEmployeeId)t	)	request

	inner join Com.tblEmployee e on e.fldid=request.fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	)q
	cross apply(select sum(fldTedadTabaghat)sumkol,fldRadifId from  dead.tblshomare 
						where  fldRadifId=q.radifid
						group by fldRadifId)sumradif

		outer apply(  select count (tblGhabreAmanat.fldid)over (partition by fldRadifId ) tedad     
	from dead .tblGhabreAmanat inner join 
				dead.tblshomare on fldshomareid=tblshomare.fldid 
				where fldRadifId=q.radifid
		group by tblGhabreAmanat.fldid,fldRadifId)amanatpor
				
	outer apply ((select count (Tedad) over (partition by fldRadifId ) tedad from (select  (tblRequestAmanat.fldid)tedad ,fldRadifId
						
						 from dead .tblRequestAmanat 
						 inner join 
						dead.tblshomare on fldshomareid=tblshomare.fldid 
						left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
						
						where  fldRadifId=q.radifid and fldIsEbtal <>1 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1 ))
						group by tblRequestAmanat.fldid,fldRadifId)t))requstpor

		)x

	where sumkol=tedadporshode
	'

	if (@GheteId<>'0')
	 set @query=@query+ ' and fldGheteId='+@GheteId
	 
	
	 set @query=@query+ 'group by x. fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
				Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot
				,Tabaghe,TabaghatKhali,sumkol,fldEmployeeId
						order by NameGhete' 
						
	end

	if (@fieldName='Nesfe')
	begin
		set @query=@query+ 'select t.fldGheteId, RadifId,fldShomare,fldNameRadif, NameGhete, ShomareId,fldNamevadiSalam
	, Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,Tabaghe
	, TabagheKhali
	 from (select fldGheteId, RadifId,fldShomare,fldNameRadif,fldNameGhete as NameGhete, ShomareId,fldNamevadiSalam
	,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,''''As Tabaghe
	,cast(fldTedadTabaghat-por.tedad  as nvarchar(1))+N'' ''+N''' +@tabaghe+ ''' as TabagheKhali
		,(isnull(por.tedad,0)+isnull(requestpor.tedad,0) ) tedadpor,fldTedadTabaghat
	,sum (isnull(por.tedad,0)+isnull(requestpor.tedad,0) ) over (partition by tabaghe.fldGheteId)sumkol
	 from tabaghe
	  outer apply (select count(*)tedad from dead.tblGhabreAmanat
						 where fldShomareId=ShomareId
					 )por
	 outer apply (select count(tblRequestAmanat.fldid)tedad from dead.tblRequestAmanat
				 left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
				 where  fldShomareId=ShomareId and fldIsEbtal<>1 
				 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1) )
				)requestpor
	)t
	where tedadpor<fldTedadTabaghat  and sumkol>0
		'
		if (@GheteId<>'0')
		set @query=@query+' and fldGheteId='+@GheteId 

		set @query=@query+'  group by  fldGheteId, RadifId,fldShomare,fldNameRadif, NameGhete, ShomareId,fldNamevadiSalam
						, Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,Tabaghe
						, TabagheKhali
						order by  fldGheteId,RadifId,ShomareId'

	end

	--select @query

	execute( @query)
GO
