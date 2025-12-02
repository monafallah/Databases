SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [ACC].[spr_DocumentDetailDelete] 
@HeaderId int,
@userId int

as
begin tran
declare @flag bit=0
declare @t table (id int)
insert @t
select fldCaseId from acc.tblDocumentRecord_Details
where fldDocument_HedearId=@HeaderId


update [ACC].[tblDocumentRecord_Details]
		set fldUserId=@userid,fldDate=getdate() 
		where fldDocument_HedearId=@HeaderId
		if (@@error<>0)
		begin
			rollback
			set @flag=1
		end
		if (@flag=0)
		begin
			DELETE
			FROM   [ACC].[tblDocumentRecord_Details]
			WHERE  fldDocument_HedearId = @HeaderId
			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end
		if (@flag=0)
		begin
			delete c from acc.tblCase as c
			inner join @t on id=c.fldid
			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end
		if (@flag=0)
		begin
		update acc.tblDocumentRecord_Header
		set fldUserId=@userId ,fldDate=getdate()
		where fldid=@HeaderId
		if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end
		if (@flag=0)
		begin
		delete from acc.tblDocumentRecord_Header
		where fldid=@HeaderId
		if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end
commit
GO
