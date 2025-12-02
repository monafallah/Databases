SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_RptSodorCheckSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  	WHERE  chk.tblSodorCheck.fldId = @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				   WHERE  chk.tblSodorCheck.fldId = @Value
							 
				if (@fieldname=N'fldIdDasteCheck')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc,dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  				  	WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				  	WHERE  chk.tblSodorCheck.fldIdDasteCheck = @Value

					if (@fieldname=N'fldDesc')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  		 WHERE  chk.tblSodorCheck.fldDesc like  @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				  WHERE  chk.tblSodorCheck.fldDesc like  @Value

					IF (@fieldname=N'fldMoshakhaseDasteCheck')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  		WHERE  chk.tblDasteCheck.fldMoshakhaseDasteCheck like  @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				  	WHERE  chk.tblDasteCheck.fldMoshakhaseDasteCheck like  @Value



							if (@fieldname=N'fldBankName')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  	WHERE  Com.tblBank.fldBankName like  @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc,dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				  	WHERE  Com.tblBank.fldBankName like  @Value


							if (@fieldname=N'fldShobeName')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc,dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  	WHERE  Com.tblSHobe.fldName like  @Value

				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc, dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
				  	WHERE  Com.tblSHobe.fldName like  @Value


	if (@fieldname=N'')
SELECT top(@h)  chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc,dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, tblEmployee_1.fldName + ' ' + tblEmployee_1.fldFamily AS fldDarVajh, tblEmployee_1.fldCodemeli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                 Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Com.tblSHobe ON Com.tblSHobe.fldId = Com.tblShomareHesabeOmoomi.fldShobeId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee_1 ON Com.tblAshkhas.fldHaghighiId = tblEmployee_1.fldId
				  
				  UNION 
SELECT top(@h)	 chk.tblSodorCheck.fldId, chk.tblSodorCheck.fldTarikhVosol, chk.tblSodorCheck.fldCodeSerialCheck,com.[GetSeparatedNumber](fldMablagh,',') as fldMablagh,
                  chk.tblSodorCheck.fldDesc,dbo.Fn_AssembelyMiladiToShamsi(chk.tblSodorCheck.fldDate) AS TarikhSabt, chk.tblDasteCheck.fldMoshakhaseDasteCheck, 
                  Com.tblSHobe.fldName AS NameShobe, Com.tblBank.fldBankName, Com.tblAshkhaseHoghoghi.fldName AS fldDarVajh, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS ShomareMeli, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                  Com.tblEmployee.fldFamily + ' ' + Com.tblEmployee.fldName AS Name_Family, CASE fldBabatFlag WHEN 1 THEN chk.tblSodorCheck.fldBabat ELSE '' END AS BabatText,com.date_to_words(chk.tblSodorCheck.fldTarikhVosol) AS TarikhShamsi,chk.[Num_ToWords]( chk.tblSodorCheck.fldMablagh) AS MablaghBeHorof
FROM     chk.tblSodorCheck INNER JOIN
                  chk.tblDasteCheck ON chk.tblSodorCheck.fldIdDasteCheck = chk.tblDasteCheck.fldId INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = chk.tblDasteCheck.fldIdShomareHesab INNER JOIN
                  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                  Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                  Com.tblUser ON Com.tblUser.fldId = chk.tblSodorCheck.fldUserId INNER JOIN
                  Com.tblAshkhas ON chk.tblSodorCheck.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId
					
	COMMIT




GO
