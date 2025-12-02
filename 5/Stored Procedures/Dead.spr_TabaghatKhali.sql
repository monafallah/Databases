SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_TabaghatKhali](@fieldName nvarchar(30), @Id int,@organid int)
as
declare @t table (id int,fldTedadTabaghat tinyint,ShomareId int)
	;with tabaghe as 
	(
		select row_number()over (partition by s.fldid order by (select 1))id,fldTedadTabaghat,s.fldid ShomareId
		from 
		 dead.tblShomare s 
		where s.fldOrganId=@organid --and a.fldid is null
		union all
		select id+1,fldTedadTabaghat,ShomareId from tabaghe 
		where  tabaghe.id<fldTedadTabaghat and tabaghe.ShomareId=ShomareId

	)
	insert @t
	select * from tabaghe

if (@fieldName='VadiSalam')
select ShomareId,fldGheteId as id from @t t inner join dead.tblshomare
	on fldid=shomareId
	inner join dead.tblradif on tblradif.fldid=fldRadifId
	inner join dead.tblGhete on tblGhete.fldid=fldgheteid
	where  (select count(*) from  dead.tblGhabreAmanat  where  t.ShomareId=fldShomareId )<t.fldTedadTabaghat and 
		( not exists(select * from   dead.tblGhabreAmanat where  t.ShomareId=fldShomareId and t.id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId)) and fldVadiSalamId=@Id
		group by ShomareId,fldGheteId
	

if (@fieldName='Ghete')
select ShomareId,fldRadifId as id from @t t inner join dead.tblshomare
	on fldid=shomareId
	inner join dead.tblradif on tblradif.fldid=fldRadifId
	inner join dead.tblGhete on tblGhete.fldid=fldgheteid
	where  (select count(*) from  dead.tblGhabreAmanat  where  t.ShomareId=fldShomareId )<t.fldTedadTabaghat and 
		( not exists(select * from   dead.tblGhabreAmanat where  t.ShomareId=fldShomareId and t.id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId)) and fldGheteId=@Id
		group by ShomareId,fldRadifId

if (@fieldName='radif')
select ShomareId, tblshomare.fldid as id from @t t inner join dead.tblshomare
	on fldid=shomareId
	inner join dead.tblradif on tblradif.fldid=fldRadifId
	inner join dead.tblGhete on tblGhete.fldid=fldgheteid
	where  (select count(*) from  dead.tblGhabreAmanat  where  t.ShomareId=fldShomareId )<t.fldTedadTabaghat and 
		( not exists(select * from   dead.tblGhabreAmanat where  t.ShomareId=fldShomareId and t.id=fldShomareTabaghe)
		or  not exists (select * from  dead.tblGhabreAmanat where fldShomareId=ShomareId)) and fldRadifId=@Id
		group by ShomareId,tblshomare.fldid 



GO
