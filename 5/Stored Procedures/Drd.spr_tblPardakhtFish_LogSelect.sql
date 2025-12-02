SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPardakhtFish_LogSelect] 
 @FieldName nvarchar(50),
 @UserId int,
 @AzTarikh nvarchar(10),
 @TaTarikh nvarchar(10),
 @fldId int,
 @LSN varchar(MAX)
as 
begin

declare @aslsn varbinary(10), @talsn varbinary(10)
	select @aslsn=sys.fn_cdc_map_time_to_lsn('smallest greater than or equal',dbo.ShamsiTOMiladi(@AzTarikh)) , @talsn=sys.fn_cdc_map_time_to_lsn('largest less than or equal', dateadd(day,1, dbo.ShamsiTOMiladi((@TaTarikh))))
	DELETE  cdc.drd_tblPardakhtFish_CT WHERE [__$operation]<>1 AND [__$start_lsn] in(SELECT [__$start_lsn] FROM cdc.drd_tblPardakhtFish_CT WHERE  [__$operation]=1)
	
	IF (@FieldName=N'UserId')
	select fldId as [کد]
	,fldFishId AS [کد فیش]
	,fldDatePardakht AS [تاریخ و زمان پرداخت]
	,(SELECT fldTitle FROM Drd.tblNahvePardakht WHERE fldId=fldNahvePardakhtId) AS [نحوه پرداخت]
	,fldPardakhtFiles_DetailId AS [کد پرداخت فایل]
	,com.MiladiTOShamsi(fldDate) AS [تاریخ پرداخت]
	,fldUserId as [کد کاربر]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=cdc.drd_tblPardakhtFish_CT.fldUserID) as [کاربر ایجاد کننده]
	, dbo.MiladiTOShamsi( cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as datetime)) as[تاریخ ایجاد] 
	,cast(cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as time) as char(8)) as [تغییرات ساعت]
	,fldDesc AS [توضیحات]
	,com.LogSelect(cdc.drd_tblPardakhtFish_CT.__$operation) as [نوع تغییرات]
	,convert(varchar(max), __$start_lsn,1 )AS [LSN]
	from cdc.drd_tblPardakhtFish_CT
	where cdc.drd_tblPardakhtFish_CT.__$seqval>=@aslsn and cdc.drd_tblPardakhtFish_CT.__$seqval<=@talsn and fldUserID=@UserId
	order by __$start_lsn desc
	
	
	IF (@FieldName=N'')
	select fldId as [کد]
	,fldFishId AS [کد فیش]
	,fldDatePardakht AS [تاریخ و زمان پرداخت]
	,(SELECT fldTitle FROM Drd.tblNahvePardakht WHERE fldId=fldNahvePardakhtId) AS [نحوه پرداخت]
	,fldPardakhtFiles_DetailId AS [کد پرداخت فایل]
	,com.MiladiTOShamsi(fldDate) AS [تاریخ پرداخت]
	,fldUserId as [کد کاربر]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=cdc.drd_tblPardakhtFish_CT.fldUserID) as [کاربر ایجاد کننده]
	, dbo.MiladiTOShamsi( cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as datetime)) as[تاریخ ایجاد] 
	,cast(cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as time) as char(8)) as [تغییرات ساعت]
	,fldDesc AS [توضیحات]
	,com.LogSelect(cdc.drd_tblPardakhtFish_CT.__$operation) as [نوع تغییرات]
	,convert(varchar(max), __$start_lsn,1 )AS [LSN]
	from cdc.drd_tblPardakhtFish_CT
	where cdc.drd_tblPardakhtFish_CT.__$seqval>=@aslsn and cdc.drd_tblPardakhtFish_CT.__$seqval<=@talsn 
	order by __$start_lsn desc
	
	if (@FieldName=N'fldId')
	begin
	select Id as [کد]
	,fldFishId AS [کد فیش]
	,fldDatePardakht AS [تاریخ و زمان پرداخت]
	,(SELECT fldTitle FROM Drd.tblNahvePardakht WHERE fldId=fldNahvePardakhtId) AS [نحوه پرداخت]
	,fldPardakhtFiles_DetailId AS [کد پرداخت فایل]
	,fldtarikh AS [تاریخ پرداخت]
	,fldUserId as [کد کاربر]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=fldUserID) as [کاربر ایجاد کننده]
	,cdcdate as[تاریخ ایجاد] 
	,cdctime as [تغییرات ساعت] 
	,fldDesc AS [توضیحات]
	,dbo.LogSelect(opr) as [نوع تغییرات] 
	,binLSN as LSN
	from dbo.fn_tblPardakhtFish(@fldId, @lsn)
	end
end
GO
