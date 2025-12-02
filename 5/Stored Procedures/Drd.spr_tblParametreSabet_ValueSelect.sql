SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_ValueSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
    set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldElamAvarezId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldElamAvarezId = @Value
	
	
	
	if (@fieldname=N'fldCodeDaramadElamAvarezId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldCodeDaramadElamAvarezId = @Value




		if (@fieldname=N'fldParametreSabetId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldParametreSabetId = @Value

	if (@fieldname=N'fldCodeDaramadElamAvarez')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldElamAvarezId IN (SELECT tblCodhayeDaramadiElamAvarez.fldElamAvarezId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@value )
	AND fldParametreSabetId IN (SELECT fldId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@value ))

	if (@fieldname=N'fldElamAvarezId_fldParametreSabetId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value]  
	WHERE  fldElamAvarezId = @Value and fldParametreSabetId=@Value1
	
	if (@fieldname=N'fldCodeDaramadElamAvarez_fldParametreSabetId')
	SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value]  
	WHERE  fldCodeDaramadElamAvarezId = @Value and fldParametreSabetId=@Value1

	if (@fieldname=N'checkElamAvarezId_ParametreSabetId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldParametreSabetId=@Value and fldElamAvarezId = @Value1 
	
	if (@fieldname=N'checkCodeDaramadElamAvarezId_ParametreSabetId')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldParametreSabetId=@Value and fldCodeDaramadElamAvarezId = @Value1 

	if (@fieldname=N'fldDesc')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
		SELECT top(@h)  [fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN N'1' ELSE '0' END fldIsCombo
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) THEN (SELECT fldTitle FROM Drd.tblComboBoxValue WHERE fldComboBoxId =(SELECT fldComboBaxId FROM Drd.tblParametreSabet WHERE fldid=fldParametreSabetId AND fldComboBaxId IS NOT NULL) AND fldValue = Drd.tblParametreSabet_Value.fldValue) ELSE '' END fldIsComboName
	,fldCodeDaramadElamAvarezId
	FROM   [Drd].[tblParametreSabet_Value] 

	COMMIT
GO
