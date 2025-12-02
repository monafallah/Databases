SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblStatusTaghsit_TakhfifInsert] 
	@ReplyId INT,
    @fldRequestId int,
    @fldTypeMojavez tinyint,
    @fldTypeRequest tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldDarsad decimal(5, 2),
    @fldMablagh bigint,
    @fldTarikh nvarchar(10),
    @fldMablaghNaghdi bigint,
    @fldTedadAghsat tinyint,
    @fldShomareMojavez nvarchar(50),
    @fldTedadMahAghsat tinyint,
    @fldJarimeTakhir bigINT,
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
						SET fldAsliValue=@fldJarimeTakhir,fldUserId=@fldUserId,fldSumAsli=@fldJarimeTakhir*1
						WHERE fldElamAvarezId=@fldElamAvarezId AND fldShomareHesabCodeDaramadId= @CodeTakhir
					END
					ELSE
					BEGIN
						select @CodeDaramadElamId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramadiElamAvarez] 
						INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad,fldSumAsli,fldAmuzeshParvareshValue)
						SELECT @CodeDaramadElamId, @fldElamAvarezId, N'کارمزد تقسیط', @CodeTakhir, @fldJarimeTakhir, 0, 0, @fldUserId, @fldDesc, getdate(),@fldShomareHesabId,1,@fldJarimeTakhir*1,0
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
					INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad,fldSumAsli,fldAmuzeshParvareshValue)
					SELECT @CodeDaramadElamId, @fldElamAvarezId, N'کارمزد تقسیط', @CodeTakhir, @fldJarimeTakhir, 0, 0, @fldUserId, @fldDesc, getdate(),@fldShomareHesabId,1,@fldJarimeTakhir*1,0
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
    IF(@ReplyId<>0)/*update Takhfifغیرفعال توسط جواد ربیعی جهت اعمال روش جدید محاسبه تخفیف*/
    begin
		IF(@flag=0)
		BEGIN
			UPDATE c 
			SET fldTakhfifMaliyatValue=null,fldTakhfifAvarezValue=null,fldTakhfifAmuzeshParvareshValue=NULL,fldSumAsli=isnull(m.fldTakhfifAsli,fldAsliValue)*fldTedad,fldTakhfifAsliValue=null,fldUserId=@fldUserId
			from drd.tblCodhayeDaramadiElamAvarez c
			left join drd.tblMablaghTakhfif m on m.fldCodeDaramadElamAvarezId=c.fldid and fldType=1
			WHERE c.fldElamAvarezId=@fldElamAvarezId 

			select @fldMablagh=sum(fldSumAsli)*@fldDarsad/100 from drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId

			UPDATE [Drd].[tblReplyTakhfif]
			SET     [fldDarsad] = @fldDarsad, [fldMablagh] = @fldMablagh, [fldShomareMajavez] = @fldShomareMojavez, 
			[fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
			WHERE  [fldId] = @ReplyId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
		IF(@flag=0)
		BEGIN
			DELETE FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldType=2
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
		IF(@flag=0)
				BEGIN
					--IF EXISTS(SELECT * FROM  Drd.tblMablaghTakhfif WHERE fldelamAvarezId=@fldElamAvarezId AND fldtype=1)
					--BEGIN
						/*select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
						INSERT INTO [Drd].[tblMablaghTakhfif]
						SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), fldTakhfifAsli-((fldTakhfifAsli)*@fldDarsad/100)
								,fldTakhfifMaliyat-((fldTakhfifMaliyat)*@fldDarsad/100),fldTakhfifAvarez-((fldTakhfifAvarez*@fldDarsad)/100),fldCodeDaramadElamAvarezId,2,@fldUserId,@fldDesc,GETDATE()
						FROM Drd.tblMablaghTakhfif
						WHERE fldElamAvarezId=@fldElamAvarezId  AND fldType=1*/
						
						 
						select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
						INSERT INTO [Drd].[tblMablaghTakhfif](fldid,fldTakhfifAsli,fldTakhfifMaliyat,fldTakhfifAvarez,fldCodeDaramadElamAvarezId,fldType,fldUserId,fldDesc,flddate,fldTakhfifAmuzeshParvareshValu)
						SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@fldDarsad/100)
						,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)-(ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)*@fldDarsad/100),ISNULL(fldTakhfifAvarezValue,fldAvarezValue)-(ISNULL(fldTakhfifAvarezValue,fldAvarezValue)*@fldDarsad/100),fldID,2,@fldUserId,@fldDesc,GETDATE()
						,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)-(ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)*@fldDarsad/100)
						FROM Drd.tblCodhayeDaramadiElamAvarez 
						WHERE fldElamAvarezId=@fldElamAvarezId 
						IF(@@ERROR<>0)
						BEGIN
							ROLLBACK
							SET @flag=1
						END
						IF(@flag=0)
						BEGIN
						--UPDATE Drd.tblCodhayeDaramadiElamAvarez 
						--SET fldTakhfifAsliValue=(SELECT fldTakhfifAsli FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
						--,fldTakhfifAvarezValue=(SELECT fldTakhfifAvarez FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
						--,fldTakhfifMaliyatValue=(SELECT fldTakhfifMaliyat FROM Drd.tblMablaghTakhfif WHERE fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
						--WHERE fldElamAvarezId=@fldElamAvarezId AND tblCodhayeDaramadiElamAvarez.fldid IN (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE  tblCodhayeDaramadiElamAvarez.fldElamAvarezId=@fldElamAvarezId AND fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldType=1)
						declare @asli1 bigint,@avarez1 int,@maliat1 int,@sum1 numeric,@takhfif1 bigint=@fldMablagh,@Amuzesh1 int
						select @sum1=sum(fldSumAsli) from drd.tblCodhayeDaramadiElamAvarez where fldelamavarezid=@fldElamAvarezId
						SELECT TOP(1) @maliat1=fldDarsadeMaliyat FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC
						SELECT TOP(1) @avarez1=fldDarsadeAvarez FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC
						SELECT TOP(1) @Amuzesh1=fldDarsadAmuzeshParvaresh FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC

						declare @maxRecord1 int,@sumBeforMax1 bigint
						select @maxRecord1= MAX(fldid)from drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId
				
						UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifMaliyatValue=0,fldTakhfifAvarezValue=0,fldTakhfifAmuzeshParvareshValue=0,fldSumAsli=(fldSumAsli*(@sum1-@takhfif1)/@sum1),fldTakhfifAsliValue=(fldSumAsli*(@sum1-@takhfif1)/@sum1)/fldTedad,fldUserId=@fldUserId
						WHERE fldElamAvarezId=@fldElamAvarezId and fldid<>@maxRecord1
				
						select @sumBeforMax1=isnull(SUM(fldsumasli),0) from drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId and fldid<>@maxRecord1
				
						UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifMaliyatValue=0,fldTakhfifAvarezValue=0,fldTakhfifAmuzeshParvareshValue=0,fldSumAsli=(@sum1-@takhfif1-@sumBeforMax1),fldTakhfifAsliValue=(@sum1-@takhfif1-@sumBeforMax1)/fldTedad,fldUserId=@fldUserId
						WHERE fldElamAvarezId=@fldElamAvarezId and fldid=@maxRecord1
				
						update f  set f.fldTakhfifAvarezValue=f.fldSumAsli*@avarez1/100.0
								,f.fldTakhfifMaliyatValue=f.fldSumAsli*@maliat1/100.0
								,f.fldTakhfifAmuzeshParvareshValue=0
								,fldUserId=@fldUserId from drd.tblCodhayeDaramadiElamAvarez as f 
								inner join drd.tblShomareHesabCodeDaramad as sh on sh.fldId=f.fldShomareHesabCodeDaramadId
								inner join drd.tblCodhayeDaramd as c on c.fldId=sh.fldCodeDaramadId and c.fldMashmooleArzesheAfzoode=1
								WHERE fldElamAvarezId=@fldElamAvarezId

								update f  set --f.fldTakhfifAvarezValue=f.fldSumAsli*@avarez1/100.0
								--,f.fldTakhfifMaliyatValue=f.fldSumAsli*@maliat1/100.0
								f.fldTakhfifAmuzeshParvareshValue=f.fldSumAsli*@Amuzesh1/100.0
								,fldUserId=@fldUserId from drd.tblCodhayeDaramadiElamAvarez as f 
								inner join drd.tblShomareHesabCodeDaramad as sh on sh.fldId=f.fldShomareHesabCodeDaramadId
								inner join drd.tblCodhayeDaramd as c on c.fldId=sh.fldCodeDaramadId and c.fldAmuzeshParvaresh=1
								WHERE fldElamAvarezId=@fldElamAvarezId
							IF(@@ERROR<>0)
							BEGIN
								ROLLBACK
								SET @flag=1
							END
						end
					--END
					/*IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId AND fldid NOT IN (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=Drd.tblCodhayeDaramadiElamAvarez.fldID))
					BEGIN
						select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
						INSERT INTO [Drd].[tblMablaghTakhfif] 
						SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), fldAsliValue-((fldAsliValue)*@fldDarsad/100)
						,(fldMaliyatValue)-((fldMaliyatValue)*@fldDarsad/100),(fldAvarezValue)-((fldAvarezValue)*@fldDarsad/100),fldID,2,@fldUserId,@fldDesc,GETDATE()
						FROM Drd.tblCodhayeDaramadiElamAvarez 
						WHERE fldElamAvarezId=@fldElamAvarezId 
						IF(@@ERROR<>0)
							BEGIN
								ROLLBACK
								SET @flag=1
							END
						IF(@flag=0)	
						BEGIN
						UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifAsliValue=fldAsliValue-(fldAsliValue*@fldDarsad/100),fldTakhfifAvarezValue=fldAvarezValue-((fldAvarezValue)*@fldDarsad/100)
						,fldTakhfifMaliyatValue=fldMaliyatValue-((fldMaliyatValue)*@fldDarsad/100),fldUserId=@fldUserId
						WHERE fldElamAvarezId=@fldElamAvarezId
							IF(@@ERROR<>0)
							BEGIN
								ROLLBACK
								SET @flag=1
							END
						END
					END*/
				END
		
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
	
		IF(@flag=0)
		BEGIN
			
			select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
			INSERT INTO [Drd].[tblMablaghTakhfif](fldid,fldTakhfifAsli,fldTakhfifMaliyat,fldTakhfifAvarez,fldCodeDaramadElamAvarezId,fldType,fldUserId,fldDesc,flddate,fldTakhfifAmuzeshParvareshValu)
			SELECT  @IdTakhfif+ ROW_NUMBER()OVER (ORDER BY fldid), ISNULL(fldTakhfifAsliValue,fldAsliValue)-(ISNULL(fldTakhfifAsliValue,fldAsliValue)*@fldDarsad/100)
			,ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)-(ISNULL(fldTakhfifMaliyatValue,fldMaliyatValue)*@fldDarsad/100),ISNULL(fldTakhfifAvarezValue,fldAvarezValue)-(ISNULL(fldTakhfifAvarezValue,fldAvarezValue)*@fldDarsad/100),fldID,2,@fldUserId,@fldDesc,GETDATE()
			,ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)-(ISNULL(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)*@fldDarsad/100)
			FROM Drd.tblCodhayeDaramadiElamAvarez 
			WHERE fldElamAvarezId=@fldElamAvarezId 
			
			
		END

		IF(@flag=0)
			BEGIN
				declare @asli bigint,@avarez int,@maliat int,@sum numeric,@takhfif bigint=@fldMablagh,@Amuzesh int
				select @sum=sum(fldSumAsli) from drd.tblCodhayeDaramadiElamAvarez where fldelamavarezid=@fldElamAvarezId
				SELECT TOP(1) @maliat=fldDarsadeMaliyat FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC
				SELECT TOP(1) @avarez=fldDarsadeAvarez FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC
				SELECT TOP(1) @Amuzesh=fldDarsadAmuzeshParvaresh FROM Com.tblMaliyatArzesheAfzoode WHERE fldFromDate<=@fldTarikh AND fldEndDate>=@fldTarikh ORDER BY fldId DESC
				declare @maxRecord int,@sumBeforMax bigint
				select @maxRecord= MAX(fldid)from drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId
				
				UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifMaliyatValue=0,fldTakhfifAvarezValue=0,fldTakhfifAmuzeshParvareshValue=0,fldSumAsli=(fldSumAsli*(@sum-@takhfif)/@sum),fldTakhfifAsliValue=(fldSumAsli*(@sum-@takhfif)/@sum)/fldTedad,fldUserId=@fldUserId
				WHERE fldElamAvarezId=@fldElamAvarezId and fldid<>@maxRecord
				
				select @sumBeforMax=isnull(SUM(fldsumasli),0) from drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId and fldid<>@maxRecord
				
				UPDATE drd.tblCodhayeDaramadiElamAvarez SET fldTakhfifMaliyatValue=0,fldTakhfifAvarezValue=0,fldTakhfifAmuzeshParvareshValue=0,fldSumAsli=(@sum-@takhfif-@sumBeforMax),fldTakhfifAsliValue=(@sum-@takhfif-@sumBeforMax)/fldTedad,fldUserId=@fldUserId
				WHERE fldElamAvarezId=@fldElamAvarezId and fldid=@maxRecord
				
				update f  set f.fldTakhfifAvarezValue=f.fldSumAsli*@avarez/100.0
						,f.fldTakhfifMaliyatValue=f.fldSumAsli*@maliat/100.0
						,f.fldTakhfifAmuzeshParvareshValue=0
						,fldUserId=@fldUserId 
						from drd.tblCodhayeDaramadiElamAvarez as f 
						inner join drd.tblShomareHesabCodeDaramad as sh on sh.fldId=f.fldShomareHesabCodeDaramadId
						inner join drd.tblCodhayeDaramd as c on c.fldId=sh.fldCodeDaramadId and c.fldMashmooleArzesheAfzoode=1
						WHERE fldElamAvarezId=@fldElamAvarezId


						update f  set --f.fldTakhfifAvarezValue=f.fldSumAsli*@avarez/100.0
						--,f.fldTakhfifMaliyatValue=f.fldSumAsli*@maliat/100.0
						f.fldTakhfifAmuzeshParvareshValue=f.fldSumAsli*@Amuzesh/100.0
						,fldUserId=@fldUserId 
						from drd.tblCodhayeDaramadiElamAvarez as f 
						inner join drd.tblShomareHesabCodeDaramad as sh on sh.fldId=f.fldShomareHesabCodeDaramadId
						inner join drd.tblCodhayeDaramd as c on c.fldId=sh.fldCodeDaramadId and c.fldAmuzeshParvaresh=1
						WHERE fldElamAvarezId=@fldElamAvarezId
				if(@@Error<>0)	
				begin
					 set @flag=1
					 Rollback
				END
			end
		END
	end			
 end
COMMIT

	
	
GO
