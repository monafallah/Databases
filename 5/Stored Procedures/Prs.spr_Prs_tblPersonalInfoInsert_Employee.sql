SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoInsert_Employee] 


    @fldSh_Shenasname nvarchar(10),
    @fldTarikhTavalod char(10),
    @fldMahalTavalodId int,
    @fldMahlSodoorId int,
    @fldAddress nvarchar(MAX),
    @fldCodePosti nvarchar(15),
    @fldEsargariId int,
    @fldSharhEsargari nvarchar(MAX),
    @fldSh_Personali nvarchar(20),
    @fldMadrakId int,
    @fldReshteTahsiliId INT,
    @fldNezamVazifeId TINYINT,
    @fldOrganPostId int,
    @fldRasteShoghli nvarchar(50),
    @fldReshteShoghli nvarchar(50),
    @fldTarikhEstekhdam char(10),
	
    @fldTabaghe nvarchar(10),
    @fldMeliyat bit,
    @fldSh_MojavezEstekhdam nvarchar(50),
    @fldTarikhMajavezEstekhdam char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldImage VARBINARY(max),
    @fldName nvarchar(100),
    @fldFamily nvarchar(100),
    @fldFatherName nvarchar(60),
    @fldCodemeli com.Codemeli,
    @fldJensiyat BIT,
    @fldStatusId INT,
    @fldDateTaghirVaziyat NVARCHAR(10),
    @fldNoeEstekhdamId INT,
    @fldTarikh NVARCHAR(10),
    @fldTaaholId INT,
    @fldTarikhSodoor NVARCHAR(10),
    @Status BIT,
    @Pasvand NVARCHAR(5) ,
    @fldEmployeeId INT,
	@fldOrganPostEjraeeId INT,
    @fldTel varchar(20),
	@fldMobile varchar(20)
    
AS 
	
	declare @fldID int ,  @mahaletavalod nvarchar(100) = NULL,    @msudor nvarchar(100) = NULL,@reshte nvarchar(300) = NULL

	BEGIN TRAN
	select @mahaletavalod=fldName from com.tblCity where fldId=@fldMahalTavalodId
	select @msudor=fldName from com.tblCity where fldId=@fldMahlSodoorId
	select @reshte=fldTitle from com.tblReshteTahsili where fldId=@fldReshteTahsiliId

	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldRasteShoghli=Com.fn_TextNormalize(@fldRasteShoghli)
	SET @fldReshteShoghli=Com.fn_TextNormalize(@fldReshteShoghli)
	SET @fldSharhEsargari=Com.fn_TextNormalize(@fldSharhEsargari)
	SET @fldFamily=Com.fn_TextNormalize(@fldFamily)
	SET @fldFatherName=Com.fn_TextNormalize(@fldFatherName)
	SET @fldName=Com.fn_TextNormalize(@fldName)
	
	DECLARE @flag BIT=0,@IDPersonalStatus INT,@IdHistory INT,@fldfileId int,@EmployeeId INT,@DetialId INT,@AshkhasId INT
	IF (EXISTS (SELECT * FROM Com.tblEmployee WHERE fldid=@fldEmployeeId) AND EXISTS (SELECT * FROM Com.tblEmployee_Detail WHERE fldEmployeeId=@fldEmployeeId))
	BEGIN
			IF(@fldImage IS null)
			BEGIN
			UPDATE [Com].[tblEmployee]
			SET    [fldName] = @fldName, [fldFamily] = @fldFamily,  [fldCodemeli] = @fldCodemeli,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatus=@Status 
			WHERE  [fldId] = @fldEmployeeId
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			IF(@flag=0)
			BEGIN
			UPDATE [Com].[tblEmployee_Detail]
			SET    [fldFatherName] = @fldFatherName, [fldJensiyat] = @fldJensiyat, [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteTahsiliId,  [fldSh_Shenasname] = @fldSh_Shenasname, [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahlSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldtel=@fldtel,fldMobile=@fldMobile
			WHERE  [fldEmployeeId] = @fldEmployeeId
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			
			END
			IF(@flag=0)
			BEGIN
			select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[Prs_tblPersonalInfo] 
			INSERT INTO [Prs].[Prs_tblPersonalInfo] ([fldId], fldEmployeeId, [fldEsargariId], [fldSharhEsargari], [fldSh_Personali],  [fldOrganPostId], [fldRasteShoghli], [fldReshteShoghli], [fldTarikhEstekhdam],  [fldTabaghe],  [fldSh_MojavezEstekhdam], [fldTarikhMajavezEstekhdam], [fldUserId], [fldDesc], [fldDate],fldOrganPostEjraeeId)
			SELECT @fldId, @fldEmployeeId,    @fldEsargariId, @fldSharhEsargari, @fldSh_Personali,    @fldOrganPostId, @fldRasteShoghli, @fldReshteShoghli, @fldTarikhEstekhdam,  @fldTabaghe,  @fldSh_MojavezEstekhdam, @fldTarikhMajavezEstekhdam, @fldUserId, @fldDesc, GETDATE(),@fldOrganPostEjraeeId
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			end
			IF(@flag=0)
			BEGIN
			select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
				INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
				SELECT @IDPersonalStatus,@fldStatusId,@fldID,NULL,@fldTarikhEstekhdam,@fldUserId,@fldDesc,GETDATE()
		   IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			end
			IF(@flag=0)
			BEGIN
			SELECT @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
				INSERT INTO Prs.tblHistoryNoeEstekhdam( fldId ,fldNoeEstekhdamId ,fldPrsPersonalInfoId ,fldTarikh ,fldUserId ,fldDesc ,fldDate)
				SELECT @IdHistory,@fldNoeEstekhdamId,@fldId,@fldTarikh,@fldUserId,@fldDesc,GETDATE()
				IF (@@ERROR<>0)
				BEGIN
				ROLLBACK
				SET @flag=1
				END
			END
			END
			ELSE 
				BEGIN
				UPDATE [Com].[tblEmployee]
				SET    [fldName] = @fldName, [fldFamily] = @fldFamily,  [fldCodemeli] = @fldCodemeli,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatus=@Status 
				WHERE  [fldId] = @fldEmployeeId
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
				SET @fldfileId=(SELECT fldFileId FROM Com.tblEmployee_Detail WHERE fldEmployeeId=@EmployeeId)
				IF(@fldfileId IS NOT NULL)
					UPDATE Com.tblFile
					SET fldImage=@fldImage ,fldPasvand=@Pasvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
					WHERE fldid=@fldfileId
				ELSE
				BEGIN
					select @fldfileId =ISNULL(max(fldId),0)+1 from Com.tblFile
					INSERT INTO Com.tblFile(fldId,fldImage,fldPasvand,fldUserId,fldDesc,fldDate)
					SELECT @fldfileId,@fldImage,@Pasvand,@fldUserId,@fldDesc,GETDATE()
					IF (@@ERROR<>0)
					BEGIN
						ROLLBACK
						SET @flag=1
					END
				END
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
				IF(@flag=0)
				BEGIN
				UPDATE [Com].[tblEmployee_Detail]
				SET    [fldFatherName] = @fldFatherName, [fldJensiyat] = @fldJensiyat, [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteTahsiliId, [fldFileId] = @fldFileId, [fldSh_Shenasname] = @fldSh_Shenasname, [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahlSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldtel=@fldtel,fldMobile=@fldMobile
				WHERE  [fldEmployeeId] = @fldEmployeeId
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
				END
				IF(@flag=0)
				BEGIN
				select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[Prs_tblPersonalInfo] 
				INSERT INTO [Prs].[Prs_tblPersonalInfo] ([fldId], fldEmployeeId, [fldEsargariId], [fldSharhEsargari], [fldSh_Personali],  [fldOrganPostId], [fldRasteShoghli], [fldReshteShoghli], [fldTarikhEstekhdam],  [fldTabaghe],  [fldSh_MojavezEstekhdam], [fldTarikhMajavezEstekhdam], [fldUserId], [fldDesc], [fldDate],fldOrganPostEjraeeId)
				SELECT @fldId, @fldEmployeeId,@fldEsargariId, @fldSharhEsargari, @fldSh_Personali,    @fldOrganPostId, @fldRasteShoghli, @fldReshteShoghli, @fldTarikhEstekhdam,  @fldTabaghe,  @fldSh_MojavezEstekhdam, @fldTarikhMajavezEstekhdam, @fldUserId, @fldDesc, GETDATE(),@fldOrganPostEjraeeId
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
				end
				IF(@flag=0)
				BEGIN
				select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
					INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
					SELECT @IDPersonalStatus,@fldStatusId,@fldID,NULL,@fldTarikhEstekhdam,@fldUserId,@fldDesc,GETDATE()
			   IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
				end
				IF(@flag=0)
				BEGIN
				SELECT @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
					INSERT INTO Prs.tblHistoryNoeEstekhdam( fldId ,fldNoeEstekhdamId ,fldPrsPersonalInfoId ,fldTarikh ,fldUserId ,fldDesc ,fldDate)
					SELECT @IdHistory,@fldNoeEstekhdamId,@fldId,@fldTarikh,@fldUserId,@fldDesc,GETDATE()
					IF (@@ERROR<>0)
					BEGIN
					ROLLBACK
					SET @flag=1
					END
				END
			END
		end
		ELSE IF EXISTS(SELECT * FROM Com.tblEmployee WHERE fldid=@fldEmployeeId) AND NOT EXISTS (SELECT * FROM Com.tblEmployee_Detail WHERE fldEmployeeId=@fldEmployeeId)	
		BEGIN
			UPDATE [Com].[tblEmployee]
			SET    [fldName] = @fldName, [fldFamily] = @fldFamily,  [fldCodemeli] = @fldCodemeli,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatus=@Status 
			WHERE  [fldId] = @fldEmployeeId
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			IF(@flag=0)
			BEGIN
			select @fldfileId =ISNULL(max(fldId),0)+1 from Com.tblFile
			INSERT INTO Com.tblFile(fldId,fldImage,fldPasvand,fldUserId,fldDesc,fldDate)
			SELECT @fldfileId,@fldImage,@Pasvand,@fldUserId,@fldDesc,GETDATE()
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			end
			IF(@flag=0)
			BEGIN
			select @DetialId =ISNULL(max(fldId),0)+1 from Com.tblEmployee_Detail
			INSERT INTO Com.tblEmployee_Detail
					( fldId ,fldEmployeeId ,fldFatherName ,fldJensiyat ,fldTarikhTavalod ,fldMadrakId ,fldNezamVazifeId ,fldTaaholId ,fldReshteId , fldFileId ,
					  fldSh_Shenasname ,fldMahalTavalodId , fldMahalSodoorId ,fldTarikhSodoor ,fldAddress ,fldCodePosti ,fldMeliyat ,fldUserId ,fldDesc ,fldDate,fldTel,fldMobile)
			SELECT @DetialId,@fldEmployeeId,@fldFatherName,@fldJensiyat,@fldTarikhTavalod,@fldMadrakId,@fldNezamVazifeId,@fldTaaholId,@fldReshteTahsiliId,@fldfileId
			,@fldSh_Shenasname,@fldMahalTavalodId,@fldMahlSodoorId,@fldTarikhSodoor,@fldAddress,@fldCodePosti,@fldMeliyat,@fldUserId,@fldDesc,GETDATE(),@fldtel,@fldmobile
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
			END
			IF(@flag=0)
			BEGIN
			select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[Prs_tblPersonalInfo] 
			INSERT INTO [Prs].[Prs_tblPersonalInfo] ([fldId], fldEmployeeId, [fldEsargariId], [fldSharhEsargari], [fldSh_Personali],  [fldOrganPostId], [fldRasteShoghli], [fldReshteShoghli], [fldTarikhEstekhdam],  [fldTabaghe],  [fldSh_MojavezEstekhdam], [fldTarikhMajavezEstekhdam], [fldUserId], [fldDesc], [fldDate],fldOrganPostEjraeeId)
			SELECT @fldId, @fldEmployeeId,@fldEsargariId, @fldSharhEsargari, @fldSh_Personali,    @fldOrganPostId, @fldRasteShoghli, @fldReshteShoghli, @fldTarikhEstekhdam,  @fldTabaghe,  @fldSh_MojavezEstekhdam, @fldTarikhMajavezEstekhdam, @fldUserId, @fldDesc, GETDATE(),@fldOrganPostEjraeeId
			if (@@ERROR<>0)
				BEGIN
				ROLLBACK
				SET @flag=1
				
				end
			END
			IF (@flag=0)
			BEGIN
				select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
				INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
				SELECT @IDPersonalStatus,@fldStatusId,@fldID,NULL,@fldTarikhEstekhdam,@fldUserId,@fldDesc,GETDATE()
			if (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
				
			END
			end
			IF (@flag=0)
			BEGIN
				SELECT @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
				INSERT INTO Prs.tblHistoryNoeEstekhdam( fldId ,fldNoeEstekhdamId ,fldPrsPersonalInfoId ,fldTarikh ,fldUserId ,fldDesc ,fldDate)
				SELECT @IdHistory,@fldNoeEstekhdamId,@fldId,@fldTarikh,@fldUserId,@fldDesc,GETDATE()
			END
		END	
		ELSE
		BEGIN
			select @EmployeeId =ISNULL(max(fldId),0)+1 from Com.tblEmployee
			INSERT INTO Com.tblEmployee( fldId ,fldName ,fldFamily ,fldCodemeli ,fldStatus , fldUserId , fldDesc ,fldDate )
			SELECT @EmployeeId,@fldName,@fldFamily,@fldCodemeli,@Status,@fldUserId,@fldDesc,GETDATE()        
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			IF(@flag=0)
			BEGIN
			select @fldfileId =ISNULL(max(fldId),0)+1 from Com.tblFile
			INSERT INTO Com.tblFile(fldId,fldImage,fldPasvand,fldUserId,fldDesc,fldDate)
			SELECT @fldfileId,@fldImage,@Pasvand,@fldUserId,@fldDesc,GETDATE()
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			END
			IF(@flag=0)
			BEGIN
			select @AshkhasId =ISNULL(max(fldId),0)+1 from [com].[tblAshkhas] 
			INSERT INTO [com].[tblAshkhas] ([fldId], [fldHaghighiId], [fldHoghoghiId], [fldUserId], [fldDesc], [fldDate])
			SELECT @AshkhasId, @EmployeeId, NULL, @fldUserId, @fldDesc, getdate()
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
			END
			IF(@flag=0)
			BEGIN
			select @DetialId =ISNULL(max(fldId),0)+1 from Com.tblEmployee_Detail
			INSERT INTO Com.tblEmployee_Detail
					( fldId ,fldEmployeeId ,fldFatherName ,fldJensiyat ,fldTarikhTavalod ,fldMadrakId ,fldNezamVazifeId ,fldTaaholId ,fldReshteId , fldFileId ,
					  fldSh_Shenasname ,fldMahalTavalodId , fldMahalSodoorId ,fldTarikhSodoor ,fldAddress ,fldCodePosti ,fldMeliyat ,fldUserId ,fldDesc ,fldDate,fldTel,fldMobile)
			SELECT @DetialId,@EmployeeId,@fldFatherName,@fldJensiyat,@fldTarikhTavalod,@fldMadrakId,@fldNezamVazifeId,@fldTaaholId,@fldReshteTahsiliId,@fldfileId
			,@fldSh_Shenasname,@fldMahalTavalodId,@fldMahlSodoorId,@fldTarikhSodoor,@fldAddress,@fldCodePosti,@fldMeliyat,@fldUserId,@fldDesc,GETDATE(),@fldtel,@fldMobile
				IF (@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
			END
			IF(@flag=0)
			BEGIN
			select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[Prs_tblPersonalInfo] 
			INSERT INTO [Prs].[Prs_tblPersonalInfo] ([fldId], fldEmployeeId, [fldEsargariId], [fldSharhEsargari], [fldSh_Personali],  [fldOrganPostId], [fldRasteShoghli], [fldReshteShoghli], [fldTarikhEstekhdam],  [fldTabaghe],  [fldSh_MojavezEstekhdam], [fldTarikhMajavezEstekhdam], [fldUserId], [fldDesc], [fldDate],fldOrganPostEjraeeId)
			SELECT @fldId, @EmployeeId,@fldEsargariId, @fldSharhEsargari, @fldSh_Personali,    @fldOrganPostId, @fldRasteShoghli, @fldReshteShoghli, @fldTarikhEstekhdam,  @fldTabaghe,  @fldSh_MojavezEstekhdam, @fldTarikhMajavezEstekhdam, @fldUserId, @fldDesc, GETDATE(),@fldOrganPostEjraeeId
			if (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
				
				end
			END
			IF (@flag=0)
			BEGIN
				select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
				INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
				SELECT @IDPersonalStatus,@fldStatusId,@fldID,NULL,@fldTarikhEstekhdam,@fldUserId,@fldDesc,GETDATE()
			if (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
				
			END
			end
			IF (@flag=0)
			BEGIN
				SELECT @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
				INSERT INTO Prs.tblHistoryNoeEstekhdam( fldId ,fldNoeEstekhdamId ,fldPrsPersonalInfoId ,fldTarikh ,fldUserId ,fldDesc ,fldDate)
				SELECT @IdHistory,@fldNoeEstekhdamId,@fldId,@fldTarikh,@fldUserId,@fldDesc,GETDATE()
		
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END	
			END
		END
		IF exists (select * from com.tblGeneralSetting where fldId=7 and  @flag=0)
		begin
		declare @a varchar(50)='',@query nvarchar(max)='',@code varchar(50)='',@date varchar(50)=CONVERT(varchar(20), getdate(), 20)
			,@organId varchar(10)
	
	select @organId= tblChartOrgan.fldOrganId from 
	 Com.tblOrganizationalPosts  INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId 
					  where tblOrganizationalPosts.fldId=@fldOrganPostId
		select @a=fldDBName from Auto_Hog.dbo.tblSetting where fldOrganId=@OrganId

			declare @id VARCHAR(10)=@fldId
			--if exists(select * from hoghugh.[dbo].[personel] where code=@fldId)
			--	select @id= max(code)+1 from hoghugh.[dbo].[personel]
			declare @setting int=0
			select @setting=fldvalue from com.tblGeneralSetting where fldId=8
			if(@setting=1)
				set @query='INSERT INTO [PAYARCHIVE].'+@a+'.[dbo].[personel] ([code], [name], [family], [nafater], [shsh], [codemeli], [tt], [enabled], [mahaletavalod], [msudor], [tahol], [vazife], [noestekhdam], [tshuro], [jensiat], [shpersenel],[madrak],  [reshte],  [tabaghe],    [raste], [code_posti], [sh_mojavez], [mojavez_date], [adres],[vaziyat])
				SELECT '+@id+',N'''+ @fldName+''',N'''+ @fldFamily+''',N'''+ @fldFatherName+''',N'''+ @fldSh_Shenasname+''',N'''+ @fldCodemeli+''',N'''+ @fldTarikhTavalod+''','+case when @status=0 then '0' else '1' end+',N'''+ @mahaletavalod+''',N'''+ @msudor+''','+cast( @fldTaaholId as varchar(10))+','+isnull( cast( @fldNezamVazifeId as varchar(10)),'null')+','+ cast( @fldNoeEstekhdamId as varchar(10))+ ',N'''+ @fldTarikhEstekhdam+''','+case when @fldJensiyat=0 then '2' else '1' end+',N'''+@fldSh_Personali+''','+cast( @fldMadrakId as varchar(10)) +',N'''+ @reshte+''','+ @fldTabaghe+',N'''+ @fldRasteShoghli+''',N'''+ @fldCodePosti+''',N'''+ @fldSh_MojavezEstekhdam+''',N'''+ @fldTarikhMajavezEstekhdam+''',N'''+ @fldAddress+''','+cast( @fldEsargariId as varchar(10))
			ELSE
				set @query='INSERT INTO '+@a+'.[dbo].[personel] ([code], [name], [family], [nafater], [shsh], [codemeli], [tt], [enabled], [mahaletavalod], [msudor], [tahol], [vazife], [noestekhdam], [tshuro], [jensiat], [shpersenel],[madrak],  [reshte],  [tabaghe],    [raste], [code_posti], [sh_mojavez], [mojavez_date], [adres],[vaziyat])
				SELECT '+@id+',N'''+ @fldName+''',N'''+ @fldFamily+''',N'''+ @fldFatherName+''',N'''+ @fldSh_Shenasname+''',N'''+ @fldCodemeli+''',N'''+ @fldTarikhTavalod+''','+case when @status=0 then '0' else '1' end+',N'''+ @mahaletavalod+''',N'''+ @msudor+''','+cast( @fldTaaholId as varchar(10))+','+isnull( cast( @fldNezamVazifeId as varchar(10)),'null')+','+ cast( @fldNoeEstekhdamId as varchar(10))+ ',N'''+ @fldTarikhEstekhdam+''','+case when @fldJensiyat=0 then '2' else '1' end+',N'''+@fldSh_Personali+''','+cast( @fldMadrakId as varchar(10)) +',N'''+ @reshte+''','+ @fldTabaghe+',N'''+ @fldRasteShoghli+''',N'''+ @fldCodePosti+''',N'''+ @fldSh_MojavezEstekhdam+''',N'''+ @fldTarikhMajavezEstekhdam+''',N'''+ @fldAddress+''','+cast( @fldEsargariId as varchar(10))
			
			execute (@query)

			if (@@ERROR<>0)
			ROLLBACK
		end	
			
			COMMIT
GO
