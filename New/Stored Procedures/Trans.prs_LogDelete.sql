SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Trans].[prs_LogDelete]( @inputId int,@NameTable varchar(100),@fldJsonParametr nvarchar(2000),@Status bit,@id int)
as 
begin tran
--declare @inputId int,@NameTable varchar(100)='tblAmadegiGhablMoayenat',@fldJsonParametr nvarchar(2000),@Status bit=1,@id int=1
declare @q nvarchar(2000)='',	  @fldRowId varbinary(8),@Name varchar(100)=''
set @Name=substring(@NameTable,charindex('.',@NameTable)+1,len(@NameTable))
create table #t  (rowid varbinary(8))
if(@status=0)
begin
	set @q='select %%physLoc%% from '+@NameTable+' where [fldid] ='+cast(@id as varchar(10))
	insert #t 
	exec (@q)
	select @fldrowId =rowid from #t
			exec  [Trans].[prs_tblSubTransactionInsert] '',
														@inputId ,
														3 ,
														0 ,
														@Name ,
														@fldRowId,
														null ,
														@fldJsonParametr 
end
else if (@status=1)
begin
SET @q='select top(1) %%physLoc%% from '+@NameTable+'History where fldID='+cast(@id as varchar(20))+ 
		' order by [StartTime] desc'
insert #t 
	exec (@q)
	select @fldrowId =rowid from #t
				exec  [Trans].[prs_tblSubTransactionInsert] '',
														@inputId ,
														3 ,
														1 ,
														@Name ,
														@fldRowId,
														null ,
														@fldJsonParametr 

end
commit
GO
