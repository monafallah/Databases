SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Trans].[prs_LogUpdate]( @inputId int,@NameTable varchar(100),@fldJsonParametr nvarchar(2000),@Status bit,@id int)
as 
begin tran
--declare @inputId int,@NameTable varchar(100)='dbo.tblAmadegiGhablMoayenat',@fldJsonParametr nvarchar(2000),@Status bit=0,@id int=8
declare    @fldRowId varbinary(8),@fldRowId_Next_Up_Del varbinary(8),@Name varchar(100)=''
set @Name=substring(@NameTable,charindex('.',@NameTable)+1,len(@NameTable))
declare @q nvarchar(1000)='',@q1 nvarchar(1000)=''
create table #rowid  (rowid varbinary(8))	
create table #RowId_Next_Up_Del  (rowid varbinary(8))
set @q='select %%physLoc%% from '+@NameTable+' where [fldid] ='+cast(@id as varchar(20))
insert #rowid 
exec (@q)
select @fldrowId =rowid from #rowid
--select * from #rowid

if(@status=0)
begin
exec  [Trans].[prs_tblSubTransactionInsert] '',
														@inputId ,
														2 ,
														0 ,
														@Name ,
														@fldRowId,
														@fldRowId_Next_Up_Del ,
														@fldJsonParametr 
end
else if (@status=1)
begin
		SET @q1='select top(1) %%physLoc%% from '+@NameTable+'History where fldID='+cast(@id as varchar(20))+ 
		' order by [StartTime] desc'
		insert #RowId_Next_Up_Del 
		exec (@q1)
		select @fldRowId_Next_Up_Del =rowid from #RowId_Next_Up_Del
		
		exec  [Trans].[prs_tblSubTransactionInsert] 'Update',
														@inputId ,
														2 ,
														1 ,
														@Name ,
														@fldRowId,
														@fldRowId_Next_Up_Del ,
														@fldJsonParametr

end
drop table #rowid
commit
GO
