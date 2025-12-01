SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [dbo].[prs_tblHeaderImageUpdateStatus] @id smallint
as
 begin tran
 begin try

 if (select fldStatus from tblHeaderImage  where fldid=@id)=0
 begin 
  update tblHeaderImage
 set fldstatus=0
 where fldid<>@id

 update tblHeaderImage
 set fldstatus=1 
 where fldid=@id
 
 end 
 else
 begin 
 update tblHeaderImage
 set fldstatus=0
 where fldid=@id





 end 
 commit 
 end try
 begin catch

  rollback

 end catch
GO
