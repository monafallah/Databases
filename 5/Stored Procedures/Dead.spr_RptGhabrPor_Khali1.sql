SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--USE [RasaNewFMS]
--GO
--/****** Object:  StoredProcedure [Dead].[spr_RptGhabrPor_Khali]    Script Date: 6/16/2022 9:24:13 AM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
create proc [Dead].[spr_RptGhabrPor_Khali1](@fieldname nvarchar(50),@Vadiid int,@Gheteid int,@radifid int,@shomareid int,@organid int)
as 
--declare @fieldname nvarchar(50)='Khali',@Vadiid int=1,@Gheteid int=1,@radifid int=0,@shomareid int=0,@organid int=1
--select 0 as GheteId,0 as RadifId,0 as ShomareId,'' aS NameGhete,'' as NameRadif,''as Shomare,''As Tabaghe,
--''as Name_Family,''Meli_Moshakhase,''As FatherName,''Sh_Sh,'' as TarikhFot,'' NameVadiSalam

declare @query nvarchar(max)='',@amant nvarchar(20)=N'قبر امانت'
declare @t table (idghete int)
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
		where fldVadiSalamId='+cast(@Vadiid as varchar(10))+' and v.fldOrganId='+cast(@organid as varchar(10) )+'
		union all
		select id+1,fldTedadTabaghat,ShomareId,fldGheteId,radifid,fldShomare,fldNameRadif,fldNameGhete,fldNamevadiSalam  from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)'
		
				
if (@fieldname='Khali')
begin
	set @query=@query+ ' select fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete as NameGhete,ShomareId,fldNamevadiSalam,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,''''As Tabaghe from tabaghe
	where  (select count(*) from  dead.tblGhabreAmanat  where ShomareId=fldShomareId )<fldTedadTabaghat'
						
	
	if (@Gheteid<>'0')
	set @query=@query+ ' and fldGheteId='+cast(@Gheteid as varchar(10))

	if (@radifid<>'0')
	set @query=@query+ ' and radifid='+cast(@radifid as varchar(15))

	if(@shomareid<>'0')
	set @query=@query+' and  ShomareId='+cast(@shomareid as varchar(15))

	set @query =@query+ ' group by fldShomare,fldNameRadif,fldNameGhete,ShomareId,fldNamevadiSalam, fldGheteId,RadifId
						order by fldShomare'
end

if (@fieldname='Por')
begin
	set @query=@query+ 'select fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(fldCodemeli,fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName,fldSh_Shenasname Sh_Sh,format( [fldTarikhFot],''####/##/##'') as TarikhFot,isnull(cast(fldShomareTabaghe  as nvarchar(20)),N'''+@amant+''')As Tabaghe from tabaghe
	inner join  [Dead].[tblGhabreAmanat]  on [fldShomareId]=ShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblMotevaffa m on fldGhabreAmanatId=tblGhabreAmanat.fldid
	where  (select count(*) from  dead.tblGhabreAmanat  where ShomareId=fldShomareId )=fldTedadTabaghat'
						
	
	if (@Gheteid<>'0')
	set @query=@query+ ' and fldGheteId='+cast(@Gheteid as varchar(10))

	if (@radifid<>'0')
	set @query=@query+ ' and radifid='+cast(@radifid as varchar(10))

	if(@shomareid<>'0')
	set @query=@query+' and ShomareId='+cast(@shomareid as varchar(10))

	set @query =@query+ ' group by fldShomare,fldNameRadif,fldNameGhete ,ShomareId,fldNamevadiSalam, 	e.fldname,e.fldFamily,fldCodemeli,fldCodeMoshakhase,fldFatherName ,fldSh_Shenasname,fldTarikhFot ,fldGheteId,RadifId,fldshomareTabaghe
						order by fldShomare'
end
if (@fieldname =N'All')
begin
	set @query=@query+ 'select * from ( select fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete,ShomareId,fldNamevadiSalam,''''as Name_Family,''''Meli_Moshakhase,''''As FatherName,''''Sh_Sh,'''' as TarikhFot,N''''As Tabaghe from tabaghe
	where  (select count(*) from  dead.tblGhabreAmanat  where ShomareId=fldShomareId )<fldTedadTabaghat
	
	union all
	select fldGheteId,RadifId,fldShomare,fldNameRadif,fldNameGhete NameGhete,ShomareId,fldNamevadiSalam,
	e.fldname+'' ''+e.fldFamily as Name_Family,isnull(fldCodemeli,fldCodeMoshakhase)Meli_Moshakhase,fldFatherName As FatherName,fldSh_Shenasname Sh_Sh,format( [fldTarikhFot],''####/##/##'') as TarikhFot,isnull(cast(fldShomareTabaghe  as nvarchar(20)),N'''+@amant+''')As Tabaghe from tabaghe
	inner join  [Dead].[tblGhabreAmanat]  on [fldShomareId]=ShomareId
	inner join Com.tblEmployee e on e.fldid=fldEmployeeId
	inner join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblMotevaffa m on fldGhabreAmanatId=tblGhabreAmanat.fldid
	where  (select count(*) from  dead.tblGhabreAmanat  where ShomareId=fldShomareId )=fldTedadTabaghat)t
	'
	declare @Query2 nvarchar(500)='' 
	if (@Gheteid<>'0')
	set @Query2= 'where fldGheteId='+cast(@Gheteid as varchar(10))

	if (@radifid<>'0' and @Query2='')
	set @Query2= 'where radifid='+cast(@radifid as varchar(10))

	else if (@radifid<>'0' and @Query2<>'')
	set @Query2= @Query2+ 'and radifid='+cast(@radifid as varchar(10))

	if(@shomareid<>'0' and @Query2='')
		set @Query2= 'where ShomareId='+cast(@shomareid as varchar(10))
	else if (@shomareid<>'0' and @Query2<>'')
		set @Query2= @Query2+ 'and ShomareId='+cast(@shomareid as varchar(10))
	
	set @query =@query+@Query2+ ' group by fldShomare,fldNameRadif,fldNameGhete,ShomareId,fldNamevadiSalam,
	 Name_Family,Meli_Moshakhase,FatherName,Sh_Sh,TarikhFot, Tabaghe ,fldGheteId,RadifId
						order by fldShomare'

end
--select @query
execute (@query)

GO
