SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Stored Procedure

CREATE PROC [Drd].[spr_tblSodoorFish_DetailInsert(Tahlil2)] 

    @fldFishId int,
    @fldCodeElamAvarezId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	DECLARE @Tarikh NVARCHAR(10),@CodeDaramad INT,@darsadNaghdi DECIMAL(5,2),@ElamAvarez INT,@IdTakhfif INT,@flag BIT=0,
	@fldTakhfifAsliValue INT,@tedad INT,@fldTakhfifAvarezValue INT,@fldTakhfifMaliyatValue int
	SELECT @CodeDaramad=fldShomareHesabCodeDaramadId,@ElamAvarez=fldElamAvarezId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldCodeElamAvarezId
	SELECT @Tarikh=com.MiladiTOShamsi(fldDate) FROM Drd.tblElamAvarez WHERE fldid=@ElamAvarez
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblSodoorFish_Detail] 
	INSERT INTO [Drd].[tblSodoorFish_Detail] ([fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldFishId, @fldCodeElamAvarezId, @fldUserId, @fldDesc, GETDATE()
	/*درصورتی یکی از کد های شماره حساب شامل تخفیف نقدی باشد if زیر اجرا میشود.*/
	IF EXISTS(SELECT TOP(1)    *    
	FROM            Drd.tblTakhfif INNER JOIN
                         Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
						WHERE fldShCodeDaramad=@CodeDaramad AND @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldTakhfifNaghdi IS NOT NULL
						ORDER BY tblTakhfif.fldId DESC)
	BEGIN
		SELECT TOP(1)   @darsadNaghdi=fldTakhfifNaghdi     
		FROM            Drd.tblTakhfif INNER JOIN
								 Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
								WHERE fldShCodeDaramad=@CodeDaramad AND @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh ORDER BY tblTakhfif.fldId DESC


		SELECT @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
		INSERT INTO [Drd].[tblMablaghTakhfif] 
		SELECT @IdTakhfif, ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@darsadNaghdi/100)
		,0,0,@fldCodeElamAvarezId,3,@fldUserId,@fldDesc,GETDATE()
		FROM Drd.tblCodhayeDaramadiElamAvarez
		WHERE fldID=@fldCodeElamAvarezId	
			IF(@@ERROR<>0)
			BEGIN
				SET @flag=1
				ROLLBACK
			END
		SELECT @fldTakhfifAsliValue=fldTakhfifAsli FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=@fldCodeElamAvarezId AND fldType=3
		SELECT @tedad=fldTedad FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldCodeElamAvarezId
		
		IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldCodeElamAvarezId AND fldMaliyatValue<>0)
			BEGIN
				SELECT TOP(1) @fldTakhfifMaliyatValue=((fldDarsadeMaliyat*(@fldTakhfifAsliValue*@tedad))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
			END
		IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldCodeElamAvarezId AND fldAvarezValue<>0)
			BEGIN
				SELECT TOP(1) @fldTakhfifAvarezValue=((fldDarsadeAvarez*(@fldTakhfifAsliValue*@tedad))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
			END

			IF (@flag=0)
				BEGIN
					UPDATE Drd.tblMablaghTakhfif 
					SET fldTakhfifMaliyat=@fldTakhfifMaliyatValue,fldTakhfifAvarez=@fldTakhfifAvarezValue
					WHERE fldCodeDaramadElamAvarezId=@fldCodeElamAvarezId AND fldType=3
						IF (@@ERROR<>0)
						BEGIN
							ROLLBACK
							SET @flag=1
						END
				END
			IF (@flag=0)
				BEGIN
					UPDATE Drd.tblCodhayeDaramadiElamAvarez
					SET fldTakhfifAsliValue=(SELECT fldTakhfifAsli FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=@fldCodeElamAvarezId AND fldType=3)
					,fldTakhfifAvarezValue=(SELECT fldTakhfifAvarez FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=@fldCodeElamAvarezId AND fldType=3)
					,fldTakhfifMaliyatValue=(SELECT fldTakhfifMaliyat FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=@fldCodeElamAvarezId AND fldType=3)
					,fldUserId=@fldUserId
					WHERE fldID=@fldCodeElamAvarezId

					IF (@@ERROR<>0)
							ROLLBACK

				END

	END
DECLARE @organId INT,@fldShomareHesabId int,@fldShorooshenaseGhabz TINYINT
SELECT @organId=fldOrganId FROM Drd.tblElamAvarez WHERE fldid=(SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@fldFishId)

SELECT      @fldShomareHesabId=  Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId,@fldShorooshenaseGhabz= Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz
FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
						 WHERE tblCodhayeDaramadiElamAvarez.fldID =@fldCodeElamAvarezId
 UPDATE Drd.tblSodoorFish
 SET fldJamKol=drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz),
 fldMablaghAvarezGerdShode=ISNULL((SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN (drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz)/1000)*1000 ELSE (drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz)/fldMablaghGerdKardan)*fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId AND fldMablaghGerdKardan<>0),drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',fldElamAvarezId,@fldShomareHesabId,@organId,@fldShorooshenaseGhabz))
	WHERE fldid=@fldFishId
	COMMIT
GO
