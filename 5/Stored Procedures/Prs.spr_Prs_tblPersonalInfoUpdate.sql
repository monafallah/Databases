SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoUpdate] 
    @fldId int,
    @fldEmployeeId int,
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
    @fldReshteTahsiliId int,
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
    @FileId INT,
    @Image VARBINARY(max),
    @Pasvand NVARCHAR(5),
    @Name NVARCHAR(100),
    @Family NVARCHAR(100),
    @FatherName NVARCHAR(100),
    @Jensiyat BIT,
    @status bit,
    @Codemeli Com.Codemeli,
    @fldTaaholId INT,
    @fldTarikhSodoor NVARCHAR(10),
	@fldOrganPostEjraeeId int,
	@fldTel varchar(20),
    @fldMobile varchar(20)
    
AS 

	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldRasteShoghli=Com.fn_TextNormalize(@fldRasteShoghli)
	SET @fldReshteShoghli=Com.fn_TextNormalize(@fldReshteShoghli)

	SET @fldSharhEsargari=Com.fn_TextNormalize(@fldSharhEsargari)
	DECLARE @flag BIT=0,@ImageId INT ,  @mahaletavalod nvarchar(100) = NULL,    @msudor nvarchar(100) = NULL,@reshte nvarchar(300) = NULL
	,@OrganIdOld int,@organId varchar(10)

	BEGIN TRAN
	select @OrganIdOld= tblChartOrgan.fldOrganId from prs.Prs_tblPersonalInfo inner join
	 Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId 
					  where Prs_tblPersonalInfo.fldId=@fldId

		select @organId= tblChartOrgan.fldOrganId from 
	 Com.tblOrganizationalPosts  INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId 
					  where tblOrganizationalPosts.fldId=@fldOrganPostId

	select @mahaletavalod=fldName from com.tblCity where fldId=@fldMahalTavalodId
	select @msudor=fldName from com.tblCity where fldId=@fldMahlSodoorId
	select @reshte=fldTitle from com.tblReshteTahsili where fldId=@fldReshteTahsiliId

	IF (@Image IS NOT NULL AND @FileId=0)
	BEGIN
		SELECT @ImageId =ISNULL(max(fldId),0)+1 from Com.tblFile
		INSERT INTO Com.tblFile ( fldId ,fldImage , fldPasvand ,fldUserId ,fldDesc ,fldDate)
		SELECT @ImageId,@Image,@Pasvand,@fldUserId,@fldDesc,GETDATE()
		IF(@@ERROR<>0)
		BEGIN
		SET @flag=1
		ROLLBACK
		END
		IF(@flag=0)
		BEGIN
		UPDATE [Com].[tblEmployee_Detail]
		SET     [fldFatherName] = @FatherName, [fldJensiyat] = @Jensiyat, [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteTahsiliId, [fldFileId] = @ImageId, [fldSh_Shenasname] = @fldSh_Shenasname, [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahlSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldtel=@fldTel,fldmobile=@fldMobile
		WHERE  [fldEmployeeId] = @fldEmployeeId
		IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END		
		END
		IF(@flag=0)
		BEGIN
		UPDATE [Prs].[Prs_tblPersonalInfo]
		SET    [fldEsargariId] = @fldEsargariId, [fldSharhEsargari] = @fldSharhEsargari, [fldSh_Personali] = @fldSh_Personali, [fldOrganPostId] = @fldOrganPostId, [fldRasteShoghli] = @fldRasteShoghli, [fldReshteShoghli] = @fldReshteShoghli, [fldTarikhEstekhdam] = @fldTarikhEstekhdam,  [fldTabaghe] = @fldTabaghe, [fldSh_MojavezEstekhdam] = @fldSh_MojavezEstekhdam, [fldTarikhMajavezEstekhdam] = @fldTarikhMajavezEstekhdam, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
		,fldOrganPostEjraeeId=@fldOrganPostEjraeeId
		WHERE  [fldId] = @fldId
		IF(@@ERROR<>0)
		ROLLBACK
		END

	END
	ELSE IF(@Image IS NULL AND @FileId<>0)
	BEGIN
	UPDATE [Prs].[Prs_tblPersonalInfo]
	
	SET    [fldId] = @fldId, [fldEmployeeId] = @fldEmployeeId,  [fldEsargariId] = @fldEsargariId, [fldSharhEsargari] = @fldSharhEsargari, [fldSh_Personali] = @fldSh_Personali, [fldOrganPostId] = @fldOrganPostId, [fldRasteShoghli] = @fldRasteShoghli, [fldReshteShoghli] = @fldReshteShoghli, [fldTarikhEstekhdam] = @fldTarikhEstekhdam,  [fldTabaghe] = @fldTabaghe, [fldSh_MojavezEstekhdam] = @fldSh_MojavezEstekhdam, [fldTarikhMajavezEstekhdam] = @fldTarikhMajavezEstekhdam, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldOrganPostEjraeeId=@fldOrganPostEjraeeId
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
		BEGIN
			UPDATE [Com].[tblEmployee_Detail]
			SET     [fldFatherName] = @FatherName, [fldJensiyat] = @Jensiyat, [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteTahsiliId, [fldFileId] = @FileId, [fldSh_Shenasname] = @fldSh_Shenasname, [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahlSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldtel=@fldTel,fldmobile=@fldMobile
			WHERE  [fldEmployeeId] = @fldEmployeeId
			IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END		
		END
	IF(@flag=0)	
	BEGIN
		UPDATE Com.tblEmployee
		SET fldName=@Name,fldFamily=@Family,fldStatus=@status,fldCodemeli=@Codemeli
		WHERE fldid=@fldEmployeeId
	end
	END
	
	ELSE
	BEGIN
	UPDATE Com.tblFile
	SET fldImage=@Image,fldPasvand=@Pasvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldId=@FileId
		IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	UPDATE [Prs].[Prs_tblPersonalInfo]
	SET     [fldEmployeeId] = @fldEmployeeId,  [fldEsargariId] = @fldEsargariId, [fldSharhEsargari] = @fldSharhEsargari, [fldSh_Personali] = @fldSh_Personali,  [fldOrganPostId] = @fldOrganPostId, [fldRasteShoghli] = @fldRasteShoghli, [fldReshteShoghli] = @fldReshteShoghli, [fldTarikhEstekhdam] = @fldTarikhEstekhdam,  [fldTabaghe] = @fldTabaghe, [fldSh_MojavezEstekhdam] = @fldSh_MojavezEstekhdam, [fldTarikhMajavezEstekhdam] = @fldTarikhMajavezEstekhdam, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldOrganPostEjraeeId=@fldOrganPostEjraeeId
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
		BEGIN
			UPDATE [Com].[tblEmployee_Detail]
			SET     [fldFatherName] = @FatherName, [fldJensiyat] = @Jensiyat, [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteTahsiliId, [fldFileId] = @FileId, [fldSh_Shenasname] = @fldSh_Shenasname, [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahlSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldtel=@fldTel,fldmobile=@fldMobile
			WHERE  [fldEmployeeId] = @fldEmployeeId
			IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END		
		END
	IF(@flag=0)	
	BEGIN
		UPDATE Com.tblEmployee
		SET fldName=@Name,fldFamily=@Family,fldStatus=@status,fldCodemeli=@Codemeli
		WHERE fldid=@fldEmployeeId
		IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END	
	END
	end
	IF exists (select * from com.tblGeneralSetting where fldId=7 and  @flag=0)	
	BEGIN
		declare @a varchar(50)='',@query nvarchar(max)='',@code varchar(50)='',@date varchar(50)=CONVERT(varchar(20), getdate(), 20)
		declare @setting int=0
			select @setting=fldvalue from com.tblGeneralSetting where fldId=8

			select @a=fldDBName from Auto_Hog.dbo.tblSetting where fldOrganId=@OrganIdOld
	if(@setting=1)
		set @query='UPDATE   [PAYARCHIVE].'+@a+'.[dbo].[personel] 
		SET    [name] = N'''+@name+''', [family] =N'''+ @family+''', [nafater] = N'''+ @FatherName+''', [shsh] = '''+  @fldSh_Shenasname+''', [codemeli] = '''+  @codemeli+''', [tt] =  '''+ @fldTarikhTavalod+''', [enabled] = '+case when  @status=0 then '0' else '1' end+', [mahaletavalod] = N'''+  @mahaletavalod+''', [msudor] = N'''+  @msudor+''', [tahol] = '+ cast( @fldTaaholId as varchar(5))+', [vazife] = '+isnull( cast( @fldNezamVazifeId as varchar(5)),N'null') +',  [madrak] = '+  cast( @fldMadrakId as varchar(5))+',  [shpersenel] = '+  @fldSh_Personali+', [reshte] = N'''+  @reshte+''', [tabaghe] = '+  @fldTabaghe+',  [raste] = N'''+  @fldRasteShoghli+''', [code_posti] = '''+  @fldCodePosti+''',   [adres] = N'''+  @fldAddress
		+''' WHERE  [codemeli] = '''+  @codemeli+''''
	ELSE 
		set @query='UPDATE  '+@a+'.[dbo].[personel] 
		SET    [name] = N'''+@name+''', [family] =N'''+ @family+''', [nafater] = N'''+ @FatherName+''', [shsh] = '''+  @fldSh_Shenasname+''', [codemeli] = '''+  @codemeli+''', [tt] =  '''+ @fldTarikhTavalod+''', [enabled] = '+case when  @status=0 then '0' else '1' end+', [mahaletavalod] = N'''+  @mahaletavalod+''', [msudor] = N'''+  @msudor+''', [tahol] = '+ cast( @fldTaaholId as varchar(5))+', [vazife] = '+isnull( cast( @fldNezamVazifeId as varchar(5)),N'null') +',  [madrak] = '+  cast( @fldMadrakId as varchar(5))+',  [shpersenel] = '+  @fldSh_Personali+', [reshte] = N'''+  @reshte+''', [tabaghe] = '+  @fldTabaghe+',  [raste] = N'''+  @fldRasteShoghli+''', [code_posti] = '''+  @fldCodePosti+''',   [adres] = N'''+  @fldAddress
		+''' WHERE  [codemeli] = '''+  @codemeli+''''
		declare @ID int 
		execute (@query)
		IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END	
	
		if(@flag=0 and @organId<>@OrganIdOld)
		begin
			
			
			if(@setting=1)
				set @query=' exec   [PAYARCHIVE].'+@a+'.dbo.prs_MoveArchive ' +''''+@Codemeli +''','+ cast(@fldUserId as varchar(10))+'  ,'+ @OrganId
			else
				set @query=' exec   '+@a+'.dbo.prs_MoveArchive ' +''''+@Codemeli +''','+ cast(@fldUserId as varchar(10))+'  ,'+ @OrganId 

					execute (@query)
					IF(@@ERROR<>0)
						BEGIN
						SET @flag=1
						ROLLBACK
						END	
		end
	end
	Commit

GO
