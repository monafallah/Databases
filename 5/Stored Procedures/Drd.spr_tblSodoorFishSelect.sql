SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSodoorFishSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN

	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      Drd.tblEbtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM       Drd.tblEbtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                       
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent  
                       FROM     Drd.tblSodoorFish
	WHERE  fldId = @Value 
	
	if (@fieldname=N'fldElamAvarezId')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent  
                          
FROM     Drd.tblSodoorFish
	WHERE  fldElamAvarezId = @Value 

	if (@fieldname=N'fldShomareHesabId')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent  
                         
FROM     Drd.tblSodoorFish
	WHERE  fldShomareHesabId = @Value 

		if (@fieldname=N'fldDesc')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent  
                         FROM     Drd.tblSodoorFish
	WHERE  Drd.tblSodoorFish.fldDesc like @Value 


	if (@fieldname=N'fldShenaseGhabz')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      Drd.tblEbtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM       Drd.tblEbtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent 
                        
FROM     Drd.tblSodoorFish
	WHERE  fldShenaseGhabz like @Value 


		if (@fieldname=N'fldShenasePardakht')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      Drd.tblEbtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM       Drd.tblEbtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent   
                       
FROM     Drd.tblSodoorFish
	WHERE  fldShenasePardakht like @Value 

			if (@fieldname=N'fldBarcode')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      Drd.tblEbtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM       Drd.tblEbtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent  
                       FROM     Drd.tblSodoorFish
	WHERE  fldBarcode like @Value

	if (@fieldname=N'')
SELECT TOP (@h) fldId, fldElamAvarezId, fldShomareHesabId, fldShenaseGhabz, fldShenasePardakht, fldMablaghAvarezGerdShode, fldShorooShenaseGhabz, fldUserId, fldDesc, 
                  fldDate, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, CASE WHEN fldid in
                      (SELECT fldFishId
                       FROM      tblebtal) THEN N'2' ELSE N'1' END AS fldStatusId, fldJamKol, fldBarcode
                        ,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent
                           
FROM     Drd.tblSodoorFish
	COMMIT
GO
