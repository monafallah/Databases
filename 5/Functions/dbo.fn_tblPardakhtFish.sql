SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[fn_tblPardakhtFish](@fldId int,@LSN varchar(max))
returns @Resulte table(Id int primary key not null,fldFishId INT,fldDatePardakht DATETIME,fldNahvePardakhtId INT,fldPardakhtFiles_DetailId INT null,fldUserID int, fldDesc nvarchar(MAX),fldTarikh NVARCHAR(10),opr int, cdcdate nchar(10), cdctime nchar(8), binLSN varchar(max))
as  
begin
	--declare @LSN varbinary(10) 
	--select @LSN=sys.fn_cdc_map_time_to_lsn('largest less than',getdate())
	declare @binLSN varbinary(10) 
	
	declare @maxlsn varbinary(10), @date nvarchar(50), @time time
	
	--select @binLSN=convert(varbinary(10),@LSN,1 )

	select @maxlsn=max(__$start_lsn) from (select * from cdc.drd_tblPardakhtFish_CT where (__$start_lsn )<= @LSN) as a
	where fldId=@fldId

	set @date=sys.fn_cdc_map_lsn_to_time(@maxlsn)
	set @time =cast(sys.fn_cdc_map_lsn_to_time(@maxlsn)as time)

	--select @maxlsn=max(__$start_lsn) from cdc.dbo_tblApplicationPart_CT where fldId=@fldId  and __$start_lsn<= @LSN
	--set @date=sys.fn_cdc_map_lsn_to_time(@maxlsn)
	--set @time =cast(sys.fn_cdc_map_lsn_to_time(@maxlsn)as time)
	insert into @Resulte
	Select top(1)  fldId ,fldFishId,fldDatePardakht,fldNahvePardakhtId,fldPardakhtFiles_DetailId
	,fldUserID ,isnull( fldDesc,''),dbo.MiladiTOShamsi(flddate)
	,__$operation , dbo.MiladiTOShamsi(@date), cast (@time as char(8))
	, convert(  varchar(max), __$start_lsn,1) from cdc.drd_tblPardakhtFish_CT

    where __$start_lsn=@maxlsn 
	order by __$operation desc

 
return
end
GO
