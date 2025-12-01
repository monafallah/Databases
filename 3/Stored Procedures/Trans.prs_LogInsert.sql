SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Trans].[prs_LogInsert]( @inputId int,@NameTable varchar(100),@fldJsonParametr nvarchar(2000),@Status bit)
as
begin tran
--declare @inputId int=1714,@NameTable varchar(100)='tblAmadegiGhablMoayenat',@fldJsonParametr nvarchar(2000),@Status bit=1,@id int=1
declare @q nvarchar(2000)='',	  @fldRowId varbinary(8),@Name varchar(100)=''
set @Name=substring(@NameTable,charindex('.',@NameTable)+1,len(@NameTable))
if(@Status=0)
begin
exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													0 ,
													@Name ,
													NULL,
													null ,
													@fldJsonParametr 
end
--else if (@Status=1)
--begin
--	create table #t  (rowid varbinary(8))
--	set @q='select %%physLoc%% from '+@NameTable+' where [fldid] ='+cast(@id as varchar(10))
--	insert #t 
--	exec (@q)
--	select @fldrowId =rowid from #t
--	exec  [Trans].[prs_tblSubTransactionInsert] '',
--													@inputId ,
--													1 ,
--													1 ,
--													@NameTable ,
--													@fldRowId,
--													null ,
--													@fldJsonParametr 
	
--end
commit
GO
