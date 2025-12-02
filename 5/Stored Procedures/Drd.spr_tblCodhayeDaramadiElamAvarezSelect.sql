SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
	WHERE  tblCodhayeDaramadiElamAvarez.fldId = @Value


	if (@fieldname=N'fldId_HesabRayan')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
					FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
	WHERE  tblCodhayeDaramadiElamAvarez.fldId = @Value

		if (@fieldname=N'fldElamAvarezId')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
					FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
                      	WHERE  tblCodhayeDaramadiElamAvarez.fldElamAvarezId = @Value
             
             
       	
                      	
	
	if (@fieldname=N'fldShomareHesabCodeDaramadId')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
					FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
                      	WHERE  fldShomareHesabCodeDaramadId = @Value

		if (@fieldname=N'fldShomareHesabId')
SELECT TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, 
                  Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, (Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue)fldAsliValue, (Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue*fldTedad)fldAvarezValue, 
                  (Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)fldMaliyatValue,Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue, Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, 
                  Drd.tblCodhayeDaramadiElamAvarez.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId,fldDaramadTitle+'('+fldDaramadCode+')' as codeDaramadTitle,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
                  ,fldTedad
				 	,0 fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint)  AS fldTakhfifAsliValue
					,ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
FROM     Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = tblCodhayeDaramd_1.fldId
	WHERE  fldShomareHesabId = @Value
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
					FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
                      	WHERE  Drd.tblCodhayeDaramadiElamAvarez.fldDesc like @Value

	if (@fieldname=N'')
SELECT     TOP (@h) Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue  AS fldMaliyatValue, 
					  Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue,
                      Drd.tblCodhayeDaramadiElamAvarez.fldUserId, Drd.tblCodhayeDaramadiElamAvarez.fldDesc, Drd.tblCodhayeDaramadiElamAvarez.fldDate, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      tblCodhayeDaramd_1.fldDaramadTitle + '(' + tblCodhayeDaramd_1.fldDaramadCode + ')' AS codeDaramadTitle, Drd.tblCodhayeDaramadiElamAvarez.fldTedad,tblCodhayeDaramd_1.fldDaramadTitle ,tblCodhayeDaramd_1.fldDaramadCode 
					,fldShorooshenaseGhabz,fldSumMablgh,cast(cast(ISNULL(cast(fldTakhfifAsliValue as bigint),cast(fldAsliValue as bigint))as bigint) * fldTedad as bigint) AS fldTakhfifAsliValue,
					ISNULL(fldTakhfifAvarezValue,fldAvarezValue)fldTakhfifAvarezValue,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)fldTakhfifMaliyatValue
					,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldTakhfifAmuzeshParvareshValue
					FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
                      
                      	COMMIT
GO
