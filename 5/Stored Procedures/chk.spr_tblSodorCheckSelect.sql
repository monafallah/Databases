SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblSodorCheckSelect] 
	@fieldname nvarchar(50),
	@Value  nvarchar(50),
	@fldOrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId,
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  chk.tblSodorCheck.fldId = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblSodorCheck.fldId = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
							 
				if (@fieldname=N'fldIdDasteCheck')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				   
				   if (@fieldname=N'fldIdDasteChek_CheckDelete')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value 
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value 

					if (@fieldname=N'fldDesc')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  chk.tblSodorCheck.fldDesc = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblSodorCheck.fldDesc = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId


					IF (@fieldname=N'fldMoshakhaseDasteCheck')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  chk.tblDasteCheck.fldMoshakhaseDasteCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblDasteCheck.fldMoshakhaseDasteCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId


							if (@fieldname=N'fldBankName')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE   Com.tblBank.fldBankName= @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  Com.tblBank.fldBankName = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				  	
if (@fieldname=N'fldCodeSerialCheck')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE chk.tblSodorCheck.fldCodeSerialCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  chk.tblSodorCheck.fldCodeSerialCheck = @Value and chk.tblSodorCheck.fldOrganId=@fldOrganId


							if (@fieldname=N'fldShobeName')
SELECT        TOP (@h)  * from (select chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN 
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId)t
				  WHERE  NameShobe = @Value and fldOrganId=@fldOrganId
				 
				  UNION 
SELECT        TOP (@h) * from(select chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId)t
				   WHERE  NameShobe = @Value and fldOrganId=@fldOrganId


				   	if (@fieldname=N'fldAshkhasId_CheckDelete')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId,
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				  WHERE  Com.tblAshkhas.fldId = @Value 
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   WHERE  Com.tblAshkhas.fldId = @Value 
					




	if (@fieldname=N'')
SELECT        TOP (@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, 
                         tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof ,
                        		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN 
                         Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
		
				 
				  UNION 
SELECT        TOP (@h) chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldIdDasteCheck, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck, chk.tblSodorCheck.fldBabat, chk.tblSodorCheck.fldBabatFlag,  chk.tblSodorCheck.fldOrganId, 
                         chk.tblSodorCheck.fldMablagh, chk.tblSodorCheck.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblSodorCheck.fldDate, chk.tblSodorCheck.fldUserId, 
                         chk.tblDasteCheck.fldMoshakhaseDasteCheck, Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, 
                         Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblAshkhas.fldId AS AshkhasId, 
                         Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText, 
                         Com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi, chk.Num_ToWords(chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof, 
                                                 		ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),4)as fldvaziat,
					                   ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده' WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده'  when 5  THEN N'عودت داده شده' END FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
					                            ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldSodorCheckId=chk.tblSodorCheck.fldId ORDER BY fldId desc),N'') fldTarikhVaziat, cf.fldTankhahGroupId,cf.fldFactorId,cf.fldContractId,isnull(cf.fldid,0) Check_FactorId
FROM            chk.tblSodorCheck INNER JOIN
                         chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                         Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                         Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                         Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId left join
						 chk.tblCheck_Factor cf on chk.tblSodorCheck.fldId=cf.fldCheckSadereId
				   
				   
				   
				   
				   
				   	COMMIT





GO
