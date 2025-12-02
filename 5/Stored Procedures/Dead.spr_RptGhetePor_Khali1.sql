SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Dead].[spr_RptGhetePor_Khali1](@fieldName nvarchar(50),@vadiSalam varchar(10),@organ varchar(10))
as 
--declare @fieldName nvarchar(50)='por',@vadiSalam varchar(10)='2',@organ varchar(10)='1'
--در فیلد نیم پر فقط قطعاتی که همه قبر های ان پر شده هستن نشان داده میشود
--select 0 fldGheteId,0RadifId,''fldShomare,''fldNameRadif,'' NameGhete,0ShomareId,''fldNamevadiSalam,
--	''Name_Family,''Meli_Moshakhase,'' As FatherName,'' Sh_Sh,'' as TarikhFot,''As Tabaghe ,''TabaghatKhali

declare @query nvarchar(max)='',@amant nvarchar(20)=N' امانت',@Rezerv nvarchar(20)=N'رزرو',@tabaghe nvarchar(10)=N'طبقه'

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

	set @query=@query+ 'select tabaghe.fldGheteId,0 RadifId,''''fldShomare,''''fldNameRadif,fldNameGhete as NameGhete,0 ShomareId,fldNamevadiSalam,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,''''As Tabaghe
	,'''' TabaghatKhali
	 from tabaghe
	  outer apply (select 1 as id,fldGheteId  from dead.tblRequestAmanat
					inner join dead.tblshomare on fldShomareId=tblshomare.fldid
					inner join dead.tblradif r on fldRadifId=r.fldid
				 left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
				 where r.fldGheteId=tabaghe.fldGheteId and fldIsEbtal<>1 
				 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1) )
				 )requestpor
	where  not exists (select * from dead.tblGhabreAmanat inner join dead.tblshomare on fldShomareId=tblShomare.fldid
					inner join dead.tblradif on fldradifid=tblradif.fldid where fldGheteId=tabaghe.fldGheteId)
					and requestpor .id is null
	 group by fldNameGhete,fldNamevadiSalam, tabaghe.fldGheteId
						order by fldGheteId'

	if (@fieldname='Por')

	set @query=@query+ 'select x. fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
	Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot
	,Tabaghe,TabaghatKhali 
	from (select q. fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
	Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot
	,Tabaghe,TabaghatKhali,ISNULL(amanatpor.tedad,0)+isnull(requstpor.tedad,0) tedadporshode,sumkol from 
	(select tabaghe.fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(fldCodemeli,fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName
	,fldSh_Shenasname Sh_Sh,coalesce(format( [fldTarikhFot],''####/##/##''),amanat.title) as TarikhFot
	,coalesce(cast(fldShomareTabaghe  as nvarchar(20)),amanat.title)As Tabaghe
	,'''' TabaghatKhali

	from tabaghe
	outer apply (select  N'''+@amant+''' Title,* from dead .tblGhabreAmanat 
		where fldShomareId=tabaghe.ShomareId)amanat
	
						
	inner join Com.tblEmployee e on e.fldid=amanat.fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblMotevaffa m on fldGhabreAmanatId=amanat.fldid
	union all
	select tabaghe.fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(fldCodemeli,fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName
	,fldSh_Shenasname Sh_Sh,request.title as TarikhFot
	,request.title As Tabaghe
	,'''' TabaghatKhali

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
	cross apply(select sum(fldTedadTabaghat)sumkol,fldGheteId from dead.tblradif
						inner join dead.tblshomare on fldRadifId=tblradif.fldid
						where fldGheteId=q.fldGheteId
						group by fldGheteId)sumghete

	outer apply(  select count (tblGhabreAmanat.fldid)over (partition by fldgheteid ) tedad     
	from dead .tblGhabreAmanat inner join 
				dead.tblshomare on fldshomareid=tblshomare.fldid 
				inner join
				dead.tblradif on fldradifid=tblradif.fldid
				where fldGheteId=q.fldgheteid
		group by tblGhabreAmanat.fldid,fldgheteid)amanatpor
				
	outer apply ((select count (Tedad) over (partition by fldgheteid ) tedad from (select  (tblRequestAmanat.fldid)tedad ,fldgheteid
						
						 from dead .tblRequestAmanat 
						 inner join 
						dead.tblshomare on fldshomareid=tblshomare.fldid 
						inner join
						dead.tblradif on fldradifid=tblradif.fldid
						left join dead.tblKartabl_Request on fldRequestId=tblRequestAmanat.fldid
						
						where  fldGheteId=q.fldgheteid and fldIsEbtal <>1 and (tblKartabl_Request.fldid is null or (tblKartabl_Request.fldid is not null and fldEtmamCharkhe<>1 ))
						group by tblRequestAmanat.fldid,fldgheteid)t))requstpor

		)x

	where sumkol=tedadporshode
	group by x.fldGheteId,RadifId,fldShomare,fldNameRadif, NameGhete,ShomareId,fldNamevadiSalam,
				Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot
				,Tabaghe,TabaghatKhali
					order by  NameGhete,fldShomare'
						

	if (@fieldname =N'Nesfe')

	set @query=@query+ 'select t.fldGheteId, RadifId,fldShomare,fldNameRadif, NameGhete, ShomareId,fldNamevadiSalam
	, Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,Tabaghe
	, TabaghatKhali
	 from (select tabaghe.fldGheteId, RadifId,fldShomare,fldNameRadif,fldNameGhete as NameGhete, ShomareId,fldNamevadiSalam
	,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,''''As Tabaghe
	,cast(fldTedadTabaghat-(isnull(por.tedad,0)+isnull(requestpor.tedad,0) ) as nvarchar(1))+N'' ''+N''' +@tabaghe+ '''  as TabaghatKhali
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
	where tedadpor<fldTedadTabaghat  and sumkol>0--and (ghtepor=t.ShomareId or ghterequest=t.ShomareId )
	group by  t.fldGheteId, RadifId,fldShomare,fldNameRadif, NameGhete, ShomareId,fldNamevadiSalam
	, Name_Family,Meli_Moshakhase, FatherName,Sh_Sh, TarikhFot,Tabaghe
	, TabaghatKhali
	order by  t.fldGheteId,RadifId,ShomareId'
	
	

--select @query
execute (@query)
GO
