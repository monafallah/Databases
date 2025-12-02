SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblDasteCheckSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	
                          WHERE chk.tblDasteCheck.fldId = @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId


							 if (@fieldname=N'fldBankName')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 
                          WHERE Com.tblBank.fldBankName like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

		if (@fieldname=N'fldShomareHesab')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 
                          WHERE fldShomareHesab like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

		if (@fieldname=N'fldTedadBarg')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 
                          WHERE fldTedadBarg like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

	if (@fieldname=N'fldShoroeSeriyal')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 
                          WHERE fldShoroeSeriyal like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

						  
	if (@fieldname=N'fldMoshakhaseDasteCheck')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 
                          WHERE fldMoshakhaseDasteCheck like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

		 if (@fieldname=N'fldShomareHesabId')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId		 
                          	 WHERE Com.tblShomareHesabeOmoomi.fldId= @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId
                          	 
if (@fieldname=N'fldShomareHesabId_Check')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId		 
                          	 WHERE Com.tblShomareHesabeOmoomi.fldId= @Value                           	 


							 		 if (@fieldname=N'fldShobeName')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	
                          WHERE Com.tblSHobe.fldName like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId


		 if (@fieldname=N'fldtitle')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId		 	
                          WHERE  chk.tblOlgoCheck.fldtitle like @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId
                         
if (@fieldname=N'fldIdOlgoCheck')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 	
                          WHERE  chk.tblOlgoCheck.fldId= @Value  and  chk.tblDasteCheck.fldOrganId=@fldOrganId  
                          
if (@fieldname=N'fldIdOlgoChek_CheckDelete')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	 	
                          WHERE  chk.tblOlgoCheck.fldId= @Value                                                


	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg, chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId		
                          WHERE chk.tblDasteCheck.fldDesc like  @Value and  chk.tblDasteCheck.fldOrganId=@fldOrganId

	if (@fieldname=N'')
SELECT     TOP (@h) chk.tblDasteCheck.fldId, chk.tblDasteCheck.fldIdOlgoCheck, chk.tblDasteCheck.fldMoshakhaseDasteCheck, chk.tblDasteCheck.fldTedadBarg,chk.tblDasteCheck.fldOrganId,
                      chk.tblDasteCheck.fldShoroeSeriyal, chk.tblDasteCheck.fldUserID, chk.tblDasteCheck.fldDesc, chk.tblDasteCheck.fldDate, 
                      chk.tblOlgoCheck.fldtitle + '(' + tblBank_1.fldBankName + ')' AS fldOlgu, chk.tblDasteCheck.fldIdShomareHesab, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                      Com.tblSHobe.fldName AS fldShobeName, Com.tblBank.fldBankName
FROM         chk.tblDasteCheck INNER JOIN
                      chk.tblOlgoCheck ON chk.tblDasteCheck.fldIdOlgoCheck = chk.tblOlgoCheck.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON chk.tblDasteCheck.fldIdShomareHesab = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON chk.tblOlgoCheck.fldIdBank = tblBank_1.fldId	
	COMMIT
GO
