SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheckHayeVaredeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647

	if (@fieldname=N'fldId')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
          ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

                        WHERE    drd.tblCheck.fldId = @value and fldOrganId=@fldOrganId  
					        

         UNION  all

SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
							   ,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE   drd.tblcheck.fldId = @value and fldOrganId=@fldOrganId
	order by tblCheck.fldid desc     
	

	if(@fieldname=N'fldNameAshkhas')
	SELECT        TOP (@h)  * FROM (SELECT   tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
       ,fldElamAvarezId
	      FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId)t
	WHERE  t.NameFamily like @Value and fldOrganId=@fldOrganId
		order by t.fldid desc     

			if (@fieldname=N'TarikhSabt')
	SELECT        TOP (@h)* FROM (SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
        ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

union  all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId)t
	WHERE  t.TarikhSabt like @Value and fldOrganId=@fldOrganId

		order by t.fldid desc     

	if (@fieldname=N'fldMablagh')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
        ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE  tblCheck.fldMablaghSanad =  @Value and fldOrganId=@fldOrganId
union all
SELECT   top(@h) tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE  tblcheck.fldMablaghSanad =  @Value and fldOrganId=@fldOrganId
		order by tblcheck.fldid desc     

		if (@fieldname=N'fldSaderKonandeh')
	SELECT        TOP (@h)*FROM (SELECT   tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
         ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId)t
	WHERE   t.fldSaderKonandeh LIKE  @Value and fldOrganId=@fldOrganId
		order by t.fldid desc     
			
			
			IF (@fieldname=N'fldTarikhVosolCheck')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
       ,fldElamAvarezId
	      FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE   tblCheck.fldTarikhSarResid LIKE  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE   tblCheck.fldTarikhSarResid LIKE  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     


				if (@fieldname=N'fldTarikhDaryaftCheck')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
         ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE   tblCheck.fldTarikhAkhz LIKE  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE   tblCheck.fldTarikhAkhz  LIKE  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     



					if (@fieldname=N'fldShenaseKamelCheck')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
         ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE   tblCheck .fldShomareSanad LIKE  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE    tblCheck .fldShomareSanad LIKE  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     


						if (@fieldname=N'fldBabat')
SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
     ,fldElamAvarezId
	      FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE   tblCheck.fldBabat LIKE  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE   tblCheck.fldBabat LIKE  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     

							if (@fieldname=N'NoeeCheckName')
	SELECT   top(@h) *from(select   tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0 then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
        ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

union all
SELECT        tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId)t
	WHERE  t.NoeeCheckName LIKE  @Value and fldOrganId=@fldOrganId
		order by t.fldid desc     

	if (@fieldname=N'fldDesc')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
        ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE tblCheck.fldDesc like  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE tblCheck.fldDesc like  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     

		if (@fieldname=N'fldShobeName')
SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
        ,fldElamAvarezId 
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE Com.tblSHobe.fldName like  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE Com.tblSHobe.fldName like  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     

	if (@fieldname=N'fldShobeId_CheckDelete')
SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
       ,fldElamAvarezId
	      FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE Com.tblSHobe.fldId =  @Value  AND fldOrganId=@fldOrganId 
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE Com.tblSHobe.fldId =  @Value  AND fldOrganId=@fldOrganId 
		order by tblCheck.fldid desc     

			if (@fieldname=N'fldBankName')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
      ,fldElamAvarezId
	      FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
WHERE  Com.tblBank.fldBankName like  @Value and fldOrganId=@fldOrganId
union all
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
	WHERE  Com.tblBank.fldBankName like  @Value and fldOrganId=@fldOrganId
		order by tblCheck.fldid desc     


	if (@fieldname=N'')
	SELECT   top(@h)  tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
							    tblEmployee_1.fldName+' '+ tblEmployee_1.fldFamily as fldSaderKonandeh, tblEmployee_1.fldCodemeli
								,N'حقیقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
         ,fldElamAvarezId
		  FROM            drd.tblCheck INNER JOIN
                         Com.tblSHobe ON  drd.tblCheck.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON  drd.tblCheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON  drd.tblCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId
 WHERE fldOrganId=@fldOrganId  
union all 
SELECT    tblCheck.fldId, tblCheck.fldshobeid fldIdShobe, tblCheck.fldMablaghSanad   fldMablagh, tblCheck.fldAshkhasId, tblCheck.fldTarikhSarResid fldTarikhVosolCheck, 
                        tblCheck.fldOrganId,tblCheck.fldTarikhAkhz fldTarikhDaryaftCheck, tblCheck.fldShomareSanad fldShenaseKamelCheck, tblCheck.fldBabat, tblCheck.fldTypeSanad fldNoeeCheck, 
                         CASE WHEN tblCheck.fldTypeSanad = 1 THEN N'امانی' WHEN tblCheck.fldTypeSanad = 0 THEN N'وصولی' END AS NoeeCheckName, tblCheck.fldUserId, 
                         tblCheck.fldDesc, tblCheck.fldDate, dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS NameFamily, CASE tblCheck.fldTypeSanad WHEN 0 THEN tblcheck.fldStatus ELSE N'' END AS fldvaziat,
						 CASE tblCheck.fldTypeSanad WHEN 0   then  CASE WHEN [tblCheck].fldStatus = 1 THEN N'در انتظار وصول' 
									WHEN [tblCheck].fldStatus = 2 THEN N'وصول شده' 
									WHEN [tblCheck].fldStatus = 3 THEN N'برگشت خورده'
									 WHEN [tblCheck].fldStatus = 4 THEN N'حقوقی شده' 
									 WHEN [tblCheck].fldStatus= 5 THEN N'عودت داده شده' end  ELSE N'' END AS NameVaziat,
									  CASE fldTypeSanad WHEN 0  then ISNULL( fldDateStatus,N'') 
									   ELSE N'' END AS fldTarikhVaziat,case when tblcheck.fldStatus is not null THEN 1 ELSE 0 END AS fldStatus,
								 Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShenaseMelli
							   ,N'حقوقی' as fldTypeShakhs,fldReceive,case when fldReceive=0 then N' دریافت نشده' else N'دریافت شده' end as fldReceiveName
,fldElamAvarezId
FROM            drd.tblcheck INNER JOIN
                         Com.tblSHobe ON tblcheck.fldshobeid = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON tblcheck.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON tblcheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
						 inner join drd.tblReplyTaghsit r on r.fldid=tblCheck.fldReplyTaghsitId

                WHERE fldOrganId=@fldOrganId          
              	order by tblCheck.fldid desc     
            
              
                         
                /* if (@fieldname=N'fldHaghighiId')
	SELECT top(@h) * FROM (	SELECT   chk.tblCheckHayeVarede.fldId , chk.tblCheckHayeVarede.fldIdShobe, chk.tblCheckHayeVarede.fldMablagh, chk.tblCheckHayeVarede.fldAshkhasId, chk.tblCheckHayeVarede.fldTarikhVosolCheck, fldOrganId,
                         chk.tblCheckHayeVarede.fldTarikhDaryaftCheck, chk.tblCheckHayeVarede.fldShenaseKamelCheck, chk.tblCheckHayeVarede.fldBabat, chk.tblCheckHayeVarede.fldNoeeCheck, 
                         CASE WHEN chk.tblCheckHayeVarede.fldNoeeCheck = 0 THEN N'امانی' WHEN chk.tblCheckHayeVarede.fldNoeeCheck = 1 THEN N'وصولی' END AS NoeeCheckName, chk.tblCheckHayeVarede.fldUserId, 
                         chk.tblCheckHayeVarede.fldDesc, chk.tblCheckHayeVarede.fldDate, dbo.Fn_AssembelyMiladiToShamsi(chk.tblCheckHayeVarede.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldSaderKonandeh,Com.tblEmployee.fldCodemeli,
									case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then	ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),1) else N'' end as fldvaziat,
					                case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then	  ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),N'در انتظار وصول' )else N'' end as  NameVaziat, 
					                case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),N'') else N'' end as  fldTarikhVaziat,(CASE when EXISTS(select * from chk.tblCheckStatus where fldCheckVaredeId=tblCheckHayeVarede.fldId ) THEN 1 ELSE 0 END )as fldStatus
                       ,N'حقیقی' as fldTypeShakhs
FROM            chk.tblCheckHayeVarede INNER JOIN
                         Com.tblSHobe ON chk.tblCheckHayeVarede.fldIdShobe = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON chk.tblCheckHayeVarede.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId)t
	        WHERE  t.fldSaderKonandeh like @Value and fldOrganId=@fldOrganId
	
	
	
	
	  if (@fieldname=N'fldHoghoghiId')
	SELECT top(@h) * FROM (	SELECT   chk.tblCheckHayeVarede.fldId , chk.tblCheckHayeVarede.fldIdShobe, chk.tblCheckHayeVarede.fldMablagh, chk.tblCheckHayeVarede.fldAshkhasId, chk.tblCheckHayeVarede.fldTarikhVosolCheck, fldOrganId,
                         chk.tblCheckHayeVarede.fldTarikhDaryaftCheck, chk.tblCheckHayeVarede.fldShenaseKamelCheck, chk.tblCheckHayeVarede.fldBabat, chk.tblCheckHayeVarede.fldNoeeCheck, 
                         CASE WHEN chk.tblCheckHayeVarede.fldNoeeCheck = 0 THEN N'امانی' WHEN chk.tblCheckHayeVarede.fldNoeeCheck = 1 THEN N'وصولی' END AS NoeeCheckName, chk.tblCheckHayeVarede.fldUserId, 
                         chk.tblCheckHayeVarede.fldDesc, chk.tblCheckHayeVarede.fldDate, dbo.Fn_AssembelyMiladiToShamsi(chk.tblCheckHayeVarede.fldDate) AS TarikhSabt, Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName, 
                         Com.tblBank.fldId AS fldBankId, Com.tblAshkhaseHoghoghi.fldName AS fldSaderKonandeh, Com.tblAshkhaseHoghoghi.fldShenaseMelli ,
									case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then	ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),1) else N'' end as fldvaziat,
					                case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then	  ISNULL( (SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),N'در انتظار وصول' )else N'' end as  NameVaziat, 
					                case chk.tblCheckHayeVarede.fldNoeeCheck  when 1 then ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldCheckVaredeId=chk.tblCheckHayeVarede.fldId ORDER BY fldId desc),N'') else N'' end as  fldTarikhVaziat,(CASE when EXISTS(select * from chk.tblCheckStatus where fldCheckVaredeId=tblCheckHayeVarede.fldId ) THEN 1 ELSE 0 END )as fldStatus
                      , N'حقوقی' as fldTypeShakhs

FROM            chk.tblCheckHayeVarede INNER JOIN
                Com.tblAshkhaseHoghoghi ON chk.tblCheckHayeVarede.fldId=Com.tblAshkhaseHoghoghi.fldId INNER join
                         Com.tblSHobe ON chk.tblCheckHayeVarede.fldIdShobe = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON chk.tblCheckHayeVarede.fldUserId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId)t 
                       
	WHERE  t.fldSaderKonandeh like @Value and fldOrganId=@fldOrganId     
                                 
         */                

	COMMIT
GO
