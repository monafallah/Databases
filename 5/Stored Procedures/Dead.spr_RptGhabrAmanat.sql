SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_RptGhabrAmanat](@fieldName varchar(50), @shomareid varchar(10),@RadifId varchar(6),@GheteId varchar(6),@Vadisalamid varchar(3),@organid varchar(5))
as 
--select   0[fldId], 0[fldShomareId], NULL[fldShomareTabaghe], 0[fldEmployeeId],0[fldOrganId],''[fldTarikhRezerv],
--		''fldname,''fldFamily,''fldShomare,''fldFatherName,''fldCodemeli,''fldSh_Shenasname,''fldCodeMoshakhase
--	,''fldNameVadiSalam,''fldNameGhete,''fldNameRadif
--	,''fldMeli_Moshakhase
--	,''Tabaghe  
declare @query nvarchar(max)='',@Manat nvarchar(50)=N'قبر امانت'
--declare @fieldName varchar(50)='Amanat', @shomareid varchar(3)=0,@RadifId varchar(3)=0 ,@GheteId varchar(3)=0,@Vadisalamid varchar(3),@organid varchar(1)=1
if (@fieldName='FotShode')
begin
set @query='SELECT  g.[fldId], [fldShomareId], [fldShomareTabaghe], g.[fldEmployeeId],g. [fldOrganId], ISNUll(format([fldTarikhFot],''####/##/##''),'''')[fldTarikhRezerv]
	,isnull(e.fldname,i.fldName)fldName,isnull(e.fldFamily,i.fldFamily)fldFamily
	,isnull(s.fldShomare,'''')fldShomare,isnull(ed.fldFatherName,fldFatherName)fldFatherName
	,isnull(fldCodemeli,fldMeliCode)fldCodemeli,isnull(fldSh_Shenasname,'''')fldSh_Shenasname
	,isnull(fldCodeMoshakhase,'''')fldCodeMoshakhase
	,isnull(v.fldName,'''') as fldNameVadiSalam,isnull(fldNameGhete,'''')fldNameGhete
	,isnull(fldNameRadif,'''')
	,isnull(isnull(fldCodemeli,fldMeliCode),fldCodeMoshakhase)fldMeli_Moshakhase
	,isnull(cast(fldShomareTabaghe as nvarchar(1)),CAST(fldTabaghe AS VARCHAR(1))) Tabaghe
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join dead.tblGhabrInfo i on i.fldid=fldGhabrInfoId
	inner join dead.tblMotevaffa on fldGhabreAmanatId=g.fldid
	inner join dead.tblGhete ge on ge.fldid=i.fldGheteId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblRadif ra on ra.fldid=fldRadifId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	where g.fldorganid='+@organid

if (@shomareid <>'0')
set @query=@query+ ' and fldShomareId='+@shomareid

if (@RadifId <>'0')
set @query=@query+ ' and ra.fldid ='+@RadifId

if (@GheteId<>'0')
set @query=@query+ ' and ge.fldid='+@GheteId

if (@Vadisalamid <>'0')
set @query=@query+ ' and v.fldid='+@Vadisalamid

--select @query
end


if (@fieldName='Amanat')
begin
set @query='SELECT  g.[fldId], isnull([fldShomareId],'''')[fldShomareId], isnull(cast(fldShomareTabaghe as nvarchar(1)),CAST(fldTabaghe AS VARCHAR(1)))[fldShomareTabaghe]
	, g.[fldEmployeeId],g. [fldOrganId], isnull(format([fldTarikhRezerv],''####/##/##''),'''')[fldTarikhRezerv]
	,isnull(e.fldname,i.fldName)fldName,isnull(e.fldFamily,i.fldFamily)fldFamily,isnull(s.fldShomare,'''')fldShomare
	,,isnull(ed.fldFatherName,fldFatherName)fldFatherName
	,isnull(fldCodemeli,fldMeliCode)fldCodemeli,isnull(fldSh_Shenasname,'''')fldSh_Shenasname
	,isnull(fldCodeMoshakhase,'''')fldCodeMoshakhase
	,isnull(v.fldName,'''') as fldNameVadiSalam,isnull(fldNameGhete,'''')fldNameGhete
	,isnull(fldNameRadif,'''')
	,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase
	,N'''+@Manat+'''  Tabaghe
	FROM   [Dead].[tblGhabreAmanat]  g 
	inner join dead.tblGhabrInfo i on i.fldid=fldGhabrInfoId
	inner join dead.tblGhete ge on ge.fldid=fldGheteId
	left join Com.tblEmployee e on e.fldid=fldEmployeeId
	left join dead.tblShomare s on s.fldid=fldShomareId
	left join com.tblEmployee_Detail ed on ed.fldEmployeeId=e.fldid
	left join dead.tblRadif ra on ra.fldid=fldRadifId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join dead.tblMotevaffa on fldGhabreAmanatId=g.fldid
	where tblMotevaffa.fldid is null and  g.fldorganid='+@organid

if (@shomareid <>'0')
set @query=@query+ ' and fldShomareId='+@shomareid

if (@RadifId <>'0')
set @query=@query+ ' and ra.fldid ='+@RadifId

if (@GheteId<>'0')
set @query=@query+ ' and ge.fldid='+@GheteId

if (@Vadisalamid <>'0')
set @query=@query+ ' and v.fldid='+@Vadisalamid

--select @query
end


 execute (@query)

GO
