SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMokatebatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID 
	WHERE  Drd.tblMokatebat.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID 
	WHERE  Drd.tblMokatebat.fldDesc like @Value
	  
	if (@fieldname=N'fldCodhayeDaramadiElamAvarezId')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID 
	WHERE  fldCodhayeDaramadiElamAvarezId = @Value
	
	if (@fieldname=N'fldSharheCodeDaramad')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID 
	WHERE  Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad like @Value
	 

	 	if (@fieldname=N'fldElamAvarezId')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID
	WHERE  Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId like @Value

	if (@fieldname=N'')
	SELECT TOP (@h) Drd.tblMokatebat.fldId, Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId, Drd.tblMokatebat.fldFileId, Drd.tblMokatebat.fldUserId, Drd.tblMokatebat.fldDesc, 
                  Drd.tblMokatebat.fldDate, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId
FROM     Drd.tblMokatebat INNER JOIN
                  Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblMokatebat.fldCodhayeDaramadiElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID 

	COMMIT
GO
