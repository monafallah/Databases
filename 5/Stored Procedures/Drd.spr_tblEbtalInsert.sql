SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblEbtalInsert] 

    @fldFishId int,
    @fldRequestTaghsit_TakhfifId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID INT,@ElamId INT ,@orgnid INT,@CodeId INT,@flag BIT=0
		DECLARE @temp TABLE (id int)
	
	SELECT @orgnid=fldOrganId FROM Drd.tblElamAvarez WHERE fldid=@ElamId
	SELECT @CodeId=fldTakhirId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@orgnid
	

	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblEbtal] 
	INSERT INTO [Drd].[tblEbtal] ([fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldFishId, @fldRequestTaghsit_TakhfifId, @fldUserId, @fldDesc, GETDATE()
	if(@@Error<>0)
	begin
		set @flag=1
		Rollback
	END
	--IF(@fldFishId IS NOT null)
	--BEGIN	
	--	SELECT @ElamId=fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@fldFishId
		
	--		INSERT INTO @temp( id )
	--		SELECT fldID FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@ElamId

	--	DELETE FROM [Drd].[tblMablaghTakhfif]  WHERE fldtype=3 AND fldCodeDaramadElamAvarezId IN (SELECT id FROM @temp)
	--	IF(@@ERROR<>0)
	--	BEGIN
	--		ROLLBACK
	--		SET @flag=1
	--	end
	--	IF(@flag=0)
	--	BEGIN
	--			--UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=(SELECT SUM(fldTakhfifAsli) FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID GROUP by fldCodeDaramadElamAvarezId ),fldTakhfifAvarezValue=(SELECT SUM(fldTakhfifAvarez) FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID  GROUP by fldCodeDaramadElamAvarezId)
	--			--			,fldTakhfifMaliyatValue=(SELECT SUM(fldTakhfifMaliyat) FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID  GROUP by fldCodeDaramadElamAvarezId),fldUserId=@fldUserId
	--			--			WHERE  fldElamAvarezId=@ElamId
	--					UPDATE drd.tblCodhayeDaramadiElamAvarez SET 	fldTakhfifAsliValue=(SELECT TOP(1) fldTakhfifAsli FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID  ORDER BY [tblMablaghTakhfif].fldId DESC),fldTakhfifAvarezValue=(SELECT TOP(1) fldTakhfifAvarez FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID   ORDER BY [tblMablaghTakhfif].fldId desc)
	--						,fldTakhfifMaliyatValue=(SELECT TOP(1) fldTakhfifMaliyat FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID  ORDER BY [tblMablaghTakhfif].fldId DESC)
						
	--						WHERE  fldElamAvarezId=@ElamId
	--	END
        
	--end

	--ELSE IF(@fldRequestTaghsit_TakhfifId IS NOT null)
	--BEGIN
	--	SELECT @ElamId=fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldId=@fldRequestTaghsit_TakhfifId
	
	--		INSERT INTO @temp( id )
	--		SELECT fldID FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@ElamId
	--	IF EXISTS (SELECT * FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@fldRequestTaghsit_TakhfifId))
	--		DELETE FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@ElamId AND fldShomareHesabCodeDaramadId=@CodeId
	
	--	IF EXISTS (SELECT * FROM Drd.tblReplyTakhfif WHERE fldStatusId IN (SELECT fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@fldRequestTaghsit_TakhfifId))
	--	BEGIN
	--		DELETE FROM [Drd].[tblMablaghTakhfif]  WHERE fldtype=2 AND fldCodeDaramadElamAvarezId IN (SELECT id FROM @temp)
	--		IF(@@ERROR<>0)
	--		BEGIN
	--			ROLLBACK
	--			SET @flag=1
	--		END
	--		IF(@flag=0)
	--		BEGIN
	--			UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=NULL,fldTakhfifAvarezValue=NULL
	--						,fldTakhfifMaliyatValue=NULL,fldUserId=@fldUserId
	--						WHERE fldID NOT IN (SELECT id FROM @temp ) AND fldElamAvarezId=@ElamId

			
	--			UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=(SELECT fldTakhfifAsli FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID),fldTakhfifAvarezValue=(SELECT fldTakhfifAvarez FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID)
	--						,fldTakhfifMaliyatValue=(SELECT fldTakhfifMaliyat FROM [Drd].[tblMablaghTakhfif] WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldID),fldUserId=@fldUserId
	--						WHERE fldID  IN (SELECT id FROM @temp )
	--		IF (@@ERROR<>0)
	--			ROLLBACK
	--		END

	--	END 
	--end

	COMMIT
GO
