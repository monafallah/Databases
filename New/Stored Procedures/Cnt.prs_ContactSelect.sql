SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [Cnt].[prs_ContactSelect] 

	@UserId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	--select ''fldname,''fldfamily,'' fldCodeMeli ,cast(0 as tinyint) fldType
--declare @userid int=1
create table #users (id int)
;with users as(
select fldId from tblUser where fldUserId=@UserId and fldId<>@UserId
union all
select tblUser.fldId from tblUser
inner join users on users.fldId=tblUser.fldUserId
)
insert #users
select * from users
union
select @userId



select top(@h) * from (select fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldType from Cnt.tblContact_Ashkhas
inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
inner join cnt.tblContact on fldContactId=tblContact.fldid
where (tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (fldtype=2 and fldUserId in (select id from #Users)) 

/*union all
select N'مراکز طب'fldname,tblAnvaMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldType from Cnt.tblContact_MarakezTeb
inner join tblAnvaMarakezTeb on fldMarazekTebId=tblAnvaMarakezTeb.fldid
inner join cnt.tblContact on fldContactId=tblContact.fldid
where (tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (fldtype=2 and fldUserId in (select id from #Users))*/)t
GO
