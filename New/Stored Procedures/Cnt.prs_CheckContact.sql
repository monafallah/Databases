SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Cnt].[prs_CheckContact]( @id int,@UserId int)
as 
begin tran
--select cast(1 as bit)flag
create table #users (id int)
declare @UserContact int--,@id int,@UserId int
select @UserContact=flduserId from cnt.tblContact where fldid=@id

;with userct as 
(select flduserId from tbluser where fldid=@UserContact
union all
select tbluser.flduserId from tbluser inner join userct
on userct.flduserId=tbluser.fldId
where tbluser.fldId<> tbluser.fldUserId
)
insert #users
select * from userct

if exists ((select * from #users where id=@UserId))
select cast(1 as bit)flag
else
select cast(0 as bit)flag

commit
GO
