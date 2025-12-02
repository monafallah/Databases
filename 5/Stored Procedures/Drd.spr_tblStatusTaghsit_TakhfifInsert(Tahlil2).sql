SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblStatusTaghsit_TakhfifInsert(Tahlil2)] 
	@ReplyId INT,
    @fldRequestId int,
    @fldTypeMojavez tinyint,
    @fldTypeRequest tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldDarsad decimal(5, 2),
    @fldMablagh int,
    @fldTarikh nvarchar(10),
    @fldMablaghNaghdi int,
    @fldTedadAghsat tinyint,
    @fldShomareMojavez nvarchar(50),
    @fldTedadMahAghsat tinyint,
    @fldJarimeTakhir INT,
	@OrganId INT,
	@fldDarsadTaaghsit DECIMAL(5,2),
	@fldDescKarmozd NVARCHAR(max)

    
    
AS 
	
	BEGIN TRAN

	set  @fldTarikh=com.fn_TextNormalize(@fldTarikh)
	set  @fldShomareMojavez=com.fn_TextNormalize(@fldShomareMojavez)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@flag bit=0 ,@fldIDD INT,@CodeTakhir int,@fldShomareHesabId INT,@fldElamAvarezId INT,@CodeDaramadElamId INT,@IdTakhfif INT
	SELECT @fldElamAvarezId=fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid=@fldRequestId
	SELECT @CodeTakhir=fldTakhirId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@OrganId
	SELECT @fldShomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@CodeTakhir
	DECLARE @t TABLE (id INT)
	SELECT fldID FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId

	 IF(@ReplyId=0)
	 BEGIN
	 SELECT @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblStatusTaghsit_Takhfif] 
	 INSERT INTO [Drd].[tblStatusTaghsit_Takhfif] ([fldId], [fldRequestId], [fldTypeMojavez], [fldTypeRequest], [fldUserId], [fldDesc], [fldDate])
	 SELECT @fldId, @fldRequestId, @fldTypeMojavez, @fldTypeRequest, @fldUserId, @fldDesc, getDate()
	  if (@@ERROR<>0)
		BEGIN
	     Set @flag=1
	     Rollback
		END
	end
		
    if (@fldTypeMojavez=1 and @flag=0)   /*موافقت*/
    begin 
    if(@fldTypeRequest=1 )/*تقسیط*/
    BEGIN
   
		IF(@ReplyId<>0)/*update taghsit*/
		BEGIN
		IF(@flag=0)
			BEGIN
				IF(@fldJarimeTakhir<>0)
				BEGIN
					IF EXISTS(SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez  WHERE fldElamAvarezId=@fldElamAvarezId AND fldShomareHesabCodeDaramadId= @CodeTakhir)
					BEGIN	
						UPDATE [tblCodhayeDaramadiElamAvarez]
						SET fldAsliValue=@fldJarimeTakhir,fldUserId=@fldUserId
						WHERE fldElamAvarezId=@fldElamAvarezId AND fldShomareHesabCodeDaramadId= @CodeTakhir
					END
					ELSE
					BEGIN
						select @CodeDaramadElamId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramadiElamAvarez] 
						INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad)
						SELECT @CodeDaramadElamId, @fldElamAvarezId, N'کارمزد تقسیط', @CodeTakhir, @fldJarimeTakhir, 0, 0, @fldUserId, @fldDesc, getdate(),@fldShomareHesabId,1
					END 
				END 
				ELSE
				BEGIN
						DELETE [tblCodhayeDaramadiElamAvarez]
						WHERE fldElamAvarezId=@fldElamAvarezId AND fldShomareHesabCodeDaramadId= @CodeTakhir
				END
				if(@@Error<>0)
				BEGIN
					SET @flag=1
					ROLLBACK
				END

			END 
			IF(@flag=0)
			BEGIN
				UPDATE tblReplyTaghsit 
				SET [fldMablaghNaghdi]=@fldMablaghNaghdi, [fldTedadAghsat]=@fldTedadAghsat, [fldShomareMojavez]=@fldShomareMojavez, [fldTarikh]=@fldTarikh, [fldUserId]=@fldUserId, [fldDesc]=@fldDesc, [fldDate]=GETDATE(),fldTedadMahAghsat=@fldTedadMahAghsat,fldJarimeTakhir=@fldJarimeTakhir,fldDarsad=@fldDarsadTaaghsit
				,fldDescKarmozd=@fldDescKarmozd
				WHERE fldId=@ReplyId
				IF(@@ERROR<>0)
				BEGIN
					ROLLBACK
				end
			END
		END
		ELSE/*insert Taghsit*/
		BEGIN
		IF(@flag=0)
			BEGIN
			 IF(@fldJarimeTakhir<>0)
				BEGIN
					select @CodeDaramadElamId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramadiElamAvarez] 
					INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad)
					SELECT @CodeDaramadElamId, @fldElamAvarezId, N'کارمزد تقسیط', @CodeTakhir, @fldJarimeTakhir, 0, 0, @fldUserId, @fldDesc, getdate(),@fldShomareHesabId,1
					IF(@@ERROR<>0)
					BEGIN
						 SET @flag=1
						 ROLLBACK
					END
				END 
			END
			IF(@flag=0)
			BEGIN
				SELECT @fldIDD =ISNULL(max(fldId),0)+1 from [Drd].[tblReplyTaghsit] 
				INSERT INTO [Drd].[tblReplyTaghsit] ([fldId],  [fldMablaghNaghdi], [fldTedadAghsat], [fldShomareMojavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate],fldStatusId,fldTedadMahAghsat,fldJarimeTakhir,fldDarsad,fldDescKarmozd)
				SELECT @fldIDD, @fldMablaghNaghdi, @fldTedadAghsat, @fldShomareMojavez, @fldTarikh, @fldUserId, @fldDesc, GETDATE(),@fldID ,@fldTedadMahAghsat,@fldJarimeTakhir,@fldDarsadTaaghsit,@fldDescKarmozd
				 if(@@ERROR<>0)
					BEGIN
					  Set @flag=1
					  Rollback
					END
			end
		end

    END 
    else if (@fldTypeRequest=2 )/*تخفیف*/
    BEGIN
    IF(@ReplyId<>0)/*update Takhfif*/
    BEGIN
		IF(@flag=0)
		BEGIN
			UPDATE [Drd].[tblReplyTakhfif]
			SET     [fldDarsad] = @fldDarsad, [fldMablagh] = @fldMablagh, [fldShomareMajavez] = @fldShomareMojavez, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
			WHERE  [fldId] = @ReplyId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
		--IF(@flag=0)
		--BEGIN
		--	DELETE FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldType=2
		--	IF(@@ERROR<>0)
		--	BEGIN
		--		ROLLBACK
		--		SET @flag=1
		--	END
		--END
		--IF(@flag=0)
		--		BEGIN
		--			IF EXISTS(SELECT * FROM  Drd.tblMablaghTakhfif WHERE fldelamAvarezId=@fldElamAvarezId AND fldtype=1)
		--			BEGIN
		--				select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
		--				INSERT INTO [Drd].[tblMablaghTakhfif]
		--				SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), fldTakhfifAsli-((fldTakhfifAsli)*@fldDarsad/100)
		--						,fldTakhfifMaliyat-((fldTakhfifMaliyat)*@fldDarsad/100),fldTakhfifAvarez-((fldTakhfifAvarez*@fldDarsad)/100),fldCodeDaramadElamAvarezId,2,@fldUserId,@fldDesc,GETDATE()
		--				FROM Drd.tblMablaghTakhfif
		--				WHERE fldElamAvarezId=@fldElamAvarezId  AND fldType=1
		--				IF(@@ERROR<>0)
		--				BEGIN
		--					ROLLBACK
		--					SET @flag=1
		--				END
		--				IF(@flag=0)
		--				BEGIN
		--				UPDATE Drd.tblCodhayeDaramadiElamAvarez 
		--				SET fldTakhfifAsliValue=(SELECT fldTakhfifAsli FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
		--				,fldTakhfifAvarezValue=(SELECT fldTakhfifAvarez FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
		--				,fldTakhfifMaliyatValue=(SELECT fldTakhfifMaliyat FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
		--				WHERE fldElamAvarezId=@fldElamAvarezId AND tblCodhayeDaramadiElamAvarez.fldid IN (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE  tblCodhayeDaramadiElamAvarez.fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
		--					IF(@@ERROR<>0)
		--					BEGIN
		--						ROLLBACK
		--						SET @flag=1
		--					END
		--				end
		--			END
		--			IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId AND fldid NOT IN (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=Drd.tblCodhayeDaramadiElamAvarez.fldID))
		--			BEGIN
		--				select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
		--				INSERT INTO [Drd].[tblMablaghTakhfif] 
		--				SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), fldAsliValue-((fldAsliValue)*@fldDarsad/100)
		--				,(fldMaliyatValue)-((fldMaliyatValue)*@fldDarsad/100),(fldAvarezValue)-((fldAvarezValue)*@fldDarsad/100),fldID,2,@fldUserId,@fldDesc,GETDATE()
		--				FROM Drd.tblCodhayeDaramadiElamAvarez 
		--				WHERE fldElamAvarezId=@fldElamAvarezId 
		--				IF(@@ERROR<>0)
		--					BEGIN
		--						ROLLBACK
		--						SET @flag=1
		--					END
		--				IF(@flag=0)	
		--				BEGIN
		--				UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=fldAsliValue-(fldAsliValue*@fldDarsad/100),fldTakhfifAvarezValue=fldAvarezValue-((fldAvarezValue)*@fldDarsad/100)
		--				,fldTakhfifMaliyatValue=fldMaliyatValue-((fldMaliyatValue)*@fldDarsad/100),fldUserId=@fldUserId
		--				WHERE fldElamAvarezId=@fldElamAvarezId
		--					IF(@@ERROR<>0)
		--					BEGIN
		--						ROLLBACK
		--						SET @flag=1
		--					END
		--				END
		--			END
		--		END
		
	END
	ELSE
	BEGIN
		IF(@flag=0)
		BEGIN
			 select @fldIDD =ISNULL(max(fldId),0)+1 from [Drd].[tblReplyTakhfif] 
			 INSERT INTO [Drd].[tblReplyTakhfif] ([fldId], [fldDarsad], [fldMablagh], [fldShomareMajavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate],fldStatusId)
			 SELECT @fldIDD, @fldDarsad, @fldMablagh, @fldShomareMojavez, @fldTarikh, @fldUserId, @fldDesc, GETDATE(),@fldID
			  if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				END
		END
	
		--IF(@flag=0)
		--BEGIN
			
		--		select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
		--	INSERT INTO [Drd].[tblMablaghTakhfif] 
		--	SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@fldDarsad/100)
		--	,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)-(ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)*@fldDarsad/100),ISNULL(fldTakhfifAvarezValue,fldAvarezValue)-(ISNULL(fldTakhfifAvarezValue,fldAvarezValue)*@fldDarsad/100),fldID,2,@fldUserId,@fldDesc,GETDATE()
		--	FROM Drd.tblCodhayeDaramadiElamAvarez 
		--	WHERE fldElamAvarezId=@fldElamAvarezId 
			
			
		--END

		--IF(@flag=0)
		--	BEGIN
				
		--		UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@fldDarsad/100),fldTakhfifAvarezValue=ISNULL(fldTakhfifAvarezValue,fldAvarezValue)-(ISNULL(fldTakhfifAvarezValue,fldAvarezValue)*@fldDarsad/100)
		--				,fldTakhfifMaliyatValue=ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)-(ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)*@fldDarsad/100),fldUserId=@fldUserId
		--				WHERE fldElamAvarezId=@fldElamAvarezId
		--		if(@@Error<>0)	
		--		begin
		--			 set @flag=1
		--			 Rollback
		--		END
		--	end
		END
	end			
 end
COMMIT

	
	
	
	
	
GO
