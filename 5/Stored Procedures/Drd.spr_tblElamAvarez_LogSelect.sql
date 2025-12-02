SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblElamAvarez_LogSelect] 
 @FieldName nvarchar(50),
 @UserId int,
 @AzTarikh nvarchar(10),
 @TaTarikh nvarchar(10),
 @fldId int,
 @LSN varchar(MAX)
as 
BEGIN tran
--DECLARE  @FieldName nvarchar(50)='userid',
-- @UserId INT=1,
-- @AzTarikh nvarchar(10)='1401/01/01',
-- @TaTarikh nvarchar(10)='1401/02/01',
-- @fldId INT=1,
-- @LSN varchar(MAX)=''
--declare @aslsn varbinary(max), @talsn varbinary(max)
--	--set @aslsn=sys.fn_cdc_map_time_to_lsn('smallest greater than or equal',com.ShamsiTOMiladi(@AzTarikh)) 
--	--set @talsn=sys.fn_cdc_map_time_to_lsn('largest less than or equal', DATEADD(day,1, com.ShamsiTOMiladi((@TaTarikh))))
--	DELETE  cdc.drd_tblElamAvarez_CT WHERE [__$operation]<>1 AND [__$start_lsn] in(SELECT [__$start_lsn] FROM cdc.drd_tblElamAvarez_CT WHERE  [__$operation]=1)
	
	--IF (@FieldName=N'UserId')
	select fldId as [کد]
	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldName+' '+fldFamily FROM  Com.tblEmployee WHERE  tblEmployee. fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
    (SELECT tblAshkhaseHoghoghi.fldName FROM      Com.tblAshkhaseHoghoghi WHERE   tblAshkhaseHoghoghi.fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = cdc.drd_tblElamAvarez_CT.fldAshakhasID)) [نام مودی]
	,Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS [شناسه ملی / کدملی]
	,fldUserId as [کد کاربر]
	, com.MiladiTOShamsi( cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as datetime)) as[تاریخ ایجاد] 
	,cast(cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as time) as char(8)) as [تغییرات ساعت]
	, com.MiladiTOShamsi(fldDate) [تاریخ]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join com.tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=cdc.drd_tblElamAvarez_CT.fldUserID) as [کاربر ایجاد کننده]
	,drd.fn_SharheCode_ElamAvarez(fldid)  as [توضیحات]
	,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid= cdc.drd_tblElamAvarez_CT.fldOrganId) AS [نام سازمان]
	, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblcompany WHERE fldKarbarId= cdc.drd_tblElamAvarez_CT.fldUserId)+' )' ELSE N'' END [نوع اعلام عوارض]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=drd_tblElamAvarez_CT.fldId),0) AS [مبلغ کلی]
	,ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ تخفیف]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=drd_tblElamAvarez_CT.fldId),0)-ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ قابل پرداخت]
	,com.LogSelect(cdc.drd_tblElamAvarez_CT.__$operation) as [نوع تغییرات]
	,convert(varchar(max), __$start_lsn,1 )AS [LSN]
	from cdc.drd_tblElamAvarez_CT
	--where cdc.drd_tblElamAvarez_CT.__$seqval>=@aslsn and cdc.drd_tblElamAvarez_CT.__$seqval<=@talsn and fldUserID=@UserId
	order by __$start_lsn desc
	
	
	IF (@FieldName=N'')
	select fldId as [کد]
	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldName+' '+fldFamily FROM  Com.tblEmployee WHERE  tblEmployee. fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
    (SELECT tblAshkhaseHoghoghi.fldName FROM      Com.tblAshkhaseHoghoghi WHERE   tblAshkhaseHoghoghi.fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = cdc.drd_tblElamAvarez_CT.fldAshakhasID)) [نام مودی]
	,Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS [شناسه ملی / کدملی]
	,fldUserId as [کد کاربر]
	, com.MiladiTOShamsi( cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as datetime)) as[تاریخ ایجاد] 
	,cast(cast( sys.fn_cdc_map_lsn_to_time( __$start_lsn)  as time) as char(8)) as [تغییرات ساعت]
	, com.MiladiTOShamsi(fldDate) [تاریخ]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join com.tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=cdc.drd_tblElamAvarez_CT.fldUserID) as [کاربر ایجاد کننده]
	,drd.fn_SharheCode_ElamAvarez(fldid)  as [توضیحات]
	,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid= cdc.drd_tblElamAvarez_CT.fldOrganId) AS [نام سازمان]
	, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblcompany WHERE fldKarbarId= cdc.drd_tblElamAvarez_CT.fldUserId)+' )' ELSE N'' END [نوع اعلام عوارض]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=drd_tblElamAvarez_CT.fldId),CAST(0 AS BIGINT)) AS [مبلغ کلی]
	,ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ تخفیف]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=drd_tblElamAvarez_CT.fldId),0)-ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ قابل پرداخت]
	,com.LogSelect(cdc.drd_tblElamAvarez_CT.__$operation) as [نوع تغییرات]
	,convert(varchar(max), __$start_lsn,1 )AS [LSN]
	from cdc.drd_tblElamAvarez_CT
--	where cdc.drd_tblElamAvarez_CT.__$seqval>=@aslsn and cdc.drd_tblElamAvarez_CT.__$seqval<=@talsn 
	order by __$start_lsn desc
	
	if (@FieldName=N'fldId')
	begin
	select Id as [کد]
	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldName+' '+fldFamily FROM  Com.tblEmployee WHERE  tblEmployee. fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
    (SELECT tblAshkhaseHoghoghi.fldName FROM      Com.tblAshkhaseHoghoghi WHERE   tblAshkhaseHoghoghi.fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId =  fldAshakhasID)) [نام مودی]
	,Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS [شناسه ملی / کدملی]
	,fldUserId as [کد کاربر]
	,cdcdate as[تاریخ ایجاد] 
	,cdctime as [تغییرات ساعت] 
	, fldTarikh [تاریخ]
	,(SELECT tblEmployee. fldName + ' ' + tblEmployee.fldFamily FROM Com.tblEmployee inner join com.tblUser on tblEmployee.fldId=tblUser.fldEmployId  WHERE tblUser. fldId=f.fldUserID) as [کاربر ایجاد کننده]
	,isnull( fldDesc,'') as [توضیحات]
	,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid= f.fldOrganId) AS [نام سازمان]
	, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblcompany WHERE fldKarbarId= f.fldUserId)+' )' ELSE N'' END [نوع اعلام عوارض]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=f.Id),0) AS [مبلغ کلی]
	,ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',Id) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ تخفیف]
	,ISNULL((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=f.Id),0)-ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',Id) AS BIGINT),CAST(0 AS BIGINT)) AS [مبلغ قابل پرداخت]
	,com.LogSelect(opr) as [نوع تغییرات] 
	,binLSN as LSN
	from dbo.fn_tblElamAvarez(@fldId, @lsn)f
	end
commit
GO
