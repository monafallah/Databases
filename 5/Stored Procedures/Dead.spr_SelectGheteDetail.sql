SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_SelectGheteDetail](@GheteId int)
as

--declare @GheteId int=2
SELECT  g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,coalesce(request.HaveRecored,amanat.HaveRecored,cast(0 as bit))ExistsRecored  
	,radif.tedad as CountRadif,shomare.tedad as CountShomare,
	(select 
		(select shomare+' |'
			from (select 'R'+substring(fldNameRadif,6,len(fldNameRadif))+''+'C'+substring(fldShomare,7,len(fldShomare))	
			+','+cast(dead.tblshomare.fldId as varchar(20))		
			+','+cast(fldTedadTabaghat as varchar(10))
			+','+cast(fot.tedad as varchar(10))
			+','+cast(rezerv.tedad+isnull(request.tedad,0) as varchar(10))
			+','+cast((fldTedadTabaghat-((select count(*) from dead.tblGhabreAmanat as g where g.fldShomareId=dead.tblshomare.fldId  )+isnull(request.tedad,0)))as varchar(10)) shomare
 from  dead.tblRadif
inner join dead.tblshomare on fldRadifId=tblRadif.fldid
outer apply (select count(*)tedad from dead.tblMotevaffa inner join dead.tblGhabreAmanat a on a.fldid=fldGhabreAmanatId where   fldShomareId=tblshomare.fldid)fot
outer apply (select count(*)tedad from dead.tblGhabreAmanat where fldTarikhRezerv is not null and fldShomareId=tblshomare.fldid)rezerv
outer apply (select count(*)tedad from dead.tblRequestAmanat 
where (not exists (select * from dead.tblKartabl_Request
where fldRequestId =tblRequestAmanat.fldid) or exists(select * from dead.tblKartabl_Request
where fldRequestId =tblRequestAmanat.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0 and tblRequestAmanat.fldShomareId=tblshomare.fldid)request
where  fldGheteId=@GheteId)t for xml path (''))) Ghete
	FROM   [Dead].[tblGhete] g inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid)amanat
	outer apply (select  top(1)  cast(1 as bit)HaveRecored from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join Dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=g.fldid and  (not exists (select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid) or exists(select * from dead.tblKartabl_Request
									where fldRequestId =gh.fldid and fldEtmamCharkhe<>1)) and fldIsEbtal=0)request
	cross apply (select count(*)tedad from Dead.tblRadif where fldGheteId=g.fldid)radif
	cross apply (select count(tblShomare.fldid)tedad from dead.tblShomare 
				cross apply (select top(1) fldid from dead.tblRadif where fldGheteId=g.fldid) r/*همه شماره های ردیف های 1 قطعه به یک اندازس*/
	 where r.fldid=fldRadifId)shomare

	WHERE  g.fldId=@GheteId
	
GO
