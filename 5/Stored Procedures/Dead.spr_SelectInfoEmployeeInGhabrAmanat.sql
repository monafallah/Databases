SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_SelectInfoEmployeeInGhabrAmanat]( @shomareId int,@ShomareTabaghe tinyint)
as
--declare @shomareId int=11,@ShomareTabaghe int=3

;with cte as 
(select max(fldShomareTabaghe)maxx ,fldshomareid from dead.tblGhabreAmanat 
	where fldShomareId=@shomareId and fldShomareTabaghe is not null
	group by fldShomareId
	
)
,rowtabaghe as
(	

	select row_number()over (order by (select 1),fldTarikh,fldDate)+isnull(maxx,0) id,fldTarikh ,fldEmployeeId,t.fldShomareId,idrequest,idamant
	from (select  fldEmployeeId,fldTarikhRezerv fldTarikh, fldDate,fldShomareId ,tblGhabreAmanat.fldid as idamant ,0 as idrequest
			from  dead.tblGhabreAmanat 
			where tblGhabreAmanat.fldShomareId=@shomareId and fldShomareTabaghe is  null
	
	union all 
	
			select fldEmployeeId,fldTarikh,fldDate,fldShomareId ,0as idamanat ,tblRequestAmanat.fldid as idrequest
			from dead.tblRequestAmanat
			where fldShomareId=@shomareId and fldisebtal<>1
			and (not exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid)
			or exists (select * from dead.tblKartabl_Request where fldRequestId=tblRequestAmanat.fldid and fldEtmamcharkhe<>1))
		)t 
	left join cte on cte.fldShomareId=t.fldShomareId	
	
)


select fldid ,fldShomareTabaghe,fldName_Family,fldFatherName,fldSh_Shenasname,fldMeli_Moshakhase,fldTarikhRezerv,fldTarikhFot,fldNameMahal
	,fldReason,fldTarikhDafn from
		(select tblGhabreAmanat.fldid,isnull(cast(fldShomareTabaghe as varchar(1)),'')fldShomareTabaghe
		,fldName +' '+fldFamily as fldName_Family,fldFatherName,fldSh_Shenasname,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(format(fldTarikhRezerv,'####/##/##'),'')fldTarikhRezerv
		,isnull(format(fldTarikhFot,'####/##/##'),'')fldTarikhFot,isnull(tblMahalFot.fldNameMahal,'')fldNameMahal,isnull(fldReason,'')fldReason
		,isnull(format(fldTarikhDafn,'####/##/##'),'')fldTarikhDafn,tblGhabreAmanat.fldShomareId
		,cast(isnull(fldShomareTabaghe,t.id)as tinyint)ShomareTabaghe
		from Dead.tblGhabreAmanat 
		inner join com.tblEmployee on fldEmployeeId=tblEmployee.fldid
		inner join com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldid
		left join dead.tblMotevaffa on fldGhabreAmanatId=tblGhabreAmanat.fldid
		left join dead.tblMahalFot on fldMahalFotId=tblMahalFot.fldid
		left join dead.tblCauseOfDeath on fldCauseOfDeathId=tblCauseOfDeath.fldid
		left join rowtabaghe t on t.idamant=tblGhabreAmanat.fldid
		where tblGhabreAmanat.fldShomareId=@shomareId

		union all
		select tblRequestAmanat.fldid,''fldShomareTabaghe,fldName +' '+fldFamily as fldName_Family,fldFatherName,fldSh_Shenasname,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(format(tblRequestAmanat.fldTarikh,'####/##/##'),'')fldTarikhRezerv
		,''fldTarikhFot,''fldNameMahal,''fldReason,''fldTarikhDafn,tblRequestAmanat.fldShomareId
		,cast(t.id as tinyint)ShomareTabaghe
		from dead.tblRequestAmanat
		inner join com.tblEmployee on fldEmployeeId=tblEmployee.fldid
		inner join com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldid
		left join rowtabaghe t on t.idrequest=tblRequestAmanat.fldid
		where tblRequestAmanat.fldShomareId=@shomareId
		)s 
	where ShomareTabaghe=@ShomareTabaghe
	--order by fldtarikhfot,fldTarikhRezer*/

GO
