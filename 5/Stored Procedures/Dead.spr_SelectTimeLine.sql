SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_SelectTimeLine](@requestId int)
as
select k.fldTitleKartabl,a.fldTitleAction,e.fldName+' '+e.fldfamily as fldName_familyUser
,dbo.Fn_AssembelyMiladiToShamsi(kr.fldDate)  as fldTarikh,cast(cast(kr.fldDate as time(0)) as varchar(10))fldTime

from dead.tblKartabl_Request kr
inner join dead.tblKartabl k on fldKartablId=k.fldid
inner join dead.tblActions a on a.fldid=fldActionId
inner join com.tblUser u on kr.flduserid=u.fldid
inner join com.tblEmployee e on e.fldid=u.fldEmployId

where fldRequestId=@requestId
GO
