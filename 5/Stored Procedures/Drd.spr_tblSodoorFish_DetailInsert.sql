SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblSodoorFish_DetailInsert] 

    @fldFishId int,
    @fldCodeElamAvarezId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	DECLARE @Tarikh NVARCHAR(10),@CodeDaramad INT,@darsadNaghdi DECIMAL(5,2),@ElamAvarez INT,@IdTakhfif INT,@flag BIT=0
	SELECT @CodeDaramad=fldShomareHesabCodeDaramadId,@ElamAvarez=fldElamAvarezId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldCodeElamAvarezId
	SELECT @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(fldDate) FROM Drd.tblElamAvarez WHERE fldid=@ElamAvarez
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblSodoorFish_Detail] 
	INSERT INTO [Drd].[tblSodoorFish_Detail] ([fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldFishId, @fldCodeElamAvarezId, @fldUserId, @fldDesc, GETDATE()
	
--	IF EXISTS(SELECT TOP(1)    *    
--FROM            Drd.tblTakhfif INNER JOIN
--                         Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--						WHERE fldShCodeDaramad=@CodeDaramad AND @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldTakhfifNaghdi IS NOT NULL
--						ORDER BY tblTakhfif.fldId DESC)
--BEGIN
--SELECT TOP(1)   @darsadNaghdi=fldTakhfifNaghdi     
--FROM            Drd.tblTakhfif INNER JOIN
--                         Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--						WHERE fldShCodeDaramad=@CodeDaramad AND @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh ORDER BY tblTakhfif.fldId DESC

--SELECT @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
--INSERT INTO [Drd].[tblMablaghTakhfif] 
--SELECT @IdTakhfif, ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@darsadNaghdi/100)
--,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)-(ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)*@darsadNaghdi/100),ISNULL(fldTakhfifAvarezValue,fldAvarezValue)-(ISNULL(fldTakhfifAvarezValue,fldAvarezValue)*@darsadNaghdi/100),@fldCodeElamAvarezId,3,@fldUserId,@fldDesc,GETDATE()
--FROM Drd.tblCodhayeDaramadiElamAvarez
--WHERE fldID=@fldCodeElamAvarezId	

--IF(@@ERROR<>0)
--BEGIN
--	SET @flag=1
--	ROLLBACK
--END
--IF (@flag=0)
--BEGIN
--UPDATE Drd.tblCodhayeDaramadiElamAvarez
--SET fldTakhfifAsliValue=fldTakhfifAsliValue-((fldTakhfifAsliValue*@darsadNaghdi)/100)
--,fldTakhfifAvarezValue=fldTakhfifAvarezValue-((fldTakhfifAvarezValue*@darsadNaghdi)/100)
--,fldTakhfifMaliyatValue=fldTakhfifMaliyatValue-((fldTakhfifMaliyatValue*@darsadNaghdi)/100)
--,fldUserId=@fldUserId
--WHERE fldID=@fldCodeElamAvarezId

--IF (@@ERROR<>0)
--		ROLLBACK

--END

--END
--DECLARE @organId INT,@fldShomareHesabId int,@fldShorooshenaseGhabz TINYINT
--SELECT @organId=fldOrganId FROM Drd.tblElamAvarez WHERE fldid=(SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@fldFishId)

--SELECT      @fldShomareHesabId=  Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId,@fldShorooshenaseGhabz= Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz
--FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
--                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
--                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
--						 WHERE tblCodhayeDaramadiElamAvarez.fldID =@fldCodeElamAvarezId
-- UPDATE Drd.tblSodoorFish
-- SET fldJamKol=drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz),fldMablaghAvarezGerdShode=ISNULL((SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN (drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz)/1000)*1000 ELSE (drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz)/fldMablaghGerdKardan)*fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId AND fldMablaghGerdKardan<>0),drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz))
--	WHERE fldid=@fldFishId
	COMMIT
GO
