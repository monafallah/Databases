SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblComputationFormulaInsert] 
	@fldId INT OUT ,
    @fldType bit,
    @fldFormule ntext,
    @fldOrganId int,
    @fldLibrary nvarchar(MAX),
    @fldAzTarikh	nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@Id int,
	@fieldname nvarchar(50)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare /*@fldID int ,*/@flag bit=0,@MohasebatId INT,@fldFormulKoliId  INT,@ParametrOmoomiid INT,@ParametrSabet INT,@DaramdGroup INT
	,@idfff int,@formalsaz varchar(max)=''
	--SELECT @MohasebatId=fldFormulMohasebatId,@fldFormulKoliId=fldFormulKoliId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@Id


	if(@fieldname='formulMohasebat')
	BEGIn
	SELECT @MohasebatId=fldFormulMohasebatId,@formalsaz=fldFormolsaz FROM Drd.tblShomareHesab_Formula WHERE fldShomareHesab_CodeId=@Id and fldTarikhEjra=@fldAzTarikh
		IF (@MohasebatId IS NOT NULL)
			BEGIN
				UPDATE Com.tblComputationFormula
					SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
					WHERE  [fldId] = @MohasebatId
					IF(@@ERROR<>0)
					BEGIN
						SET @flag=1
						ROLLBACK
					END	
					IF(@flag=0)
					BEGIN
						UPDATE Drd.tblShomareHesab_Formula
						SET fldFormolsaz=NULL
						WHERE fldShomareHesab_CodeId=@Id and fldTarikhEjra=@fldAzTarikh
					END
			END
		ELSE
		BEGIN
			SELECT @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblComputationFormula] 
			INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
			SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0) and  @formalsaz <>'' and @formalsaz is not null

			begin
				
						UPDATE Drd.tblShomareHesab_Formula
						SET fldFormolsaz=NULL ,fldFormulMohasebatId=@fldId
						WHERE fldShomareHesab_CodeId=@Id and fldTarikhEjra=@fldAzTarikh
						if(@@Error<>0)
							begin
								 set @flag=1
								 Rollback
							end

			end
			if (@flag=0) and(  @formalsaz ='' or @formalsaz is null)
			begin
				select @idfff =ISNULL(max(fldId),0)+1 from [Drd].[tblShomareHesab_Formula] 

				INSERT INTO [Drd].[tblShomareHesab_Formula] ([fldId], [fldShomareHesab_CodeId], [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId], [fldTarikhEjra], [fldDate], [fldUserId])
				SELECT @idfff, @id, NULL, NULL, @fldId, @fldAzTarikh, getdate(), @fldUserId

				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
	END
	end
	
	if(@fieldname='FormulKoli')
	BEGIN
	SELECT @fldFormulKoliId=fldFormulKoliId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@Id
		IF (@fldFormulKoliId IS NOT NULL)
		BEGIN
				UPDATE Com.tblComputationFormula
				SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
				WHERE  [fldId] = @fldFormulKoliId
					
		END
		ELSE
		BEGIN
			select @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblComputationFormula] 
			INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
			SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update Drd.tblShomareHesabCodeDaramad 
			Set fldFormulKoliId=@fldId
			where fldId=@Id 
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			END
		end
	end
	if(@fieldname='FormulOmoomi')
	BEGIN
		SELECT @ParametrOmoomiid=fldFormulId FROM Drd.tblParametreOmoomi WHERE fldid=@id
		IF(@ParametrOmoomiid IS NOT NULL)
		BEGIN
				UPDATE Com.tblComputationFormula
				SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
				WHERE  [fldId] = @ParametrOmoomiid
		END
		ELSE
		BEGIN
		select @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblComputationFormula] 
		INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
		if(@@Error<>0)
		begin
			 set @flag=1
			 Rollback
		end
		
		if (@flag=0)
		begin
			Update Drd.tblParametreOmoomi
			Set fldFormulId=@fldId
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			END
		END
		
	end
	if(@fieldname='FormulSabet')
	BEGIN
	SELECT @ParametrSabet=fldFormulId FROM Drd.tblParametreSabet WHERE fldid=@id
	IF( @ParametrSabet IS NOT NULL)
	BEGIN
			UPDATE Com.tblComputationFormula
			SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
			WHERE  [fldId] = @ParametrSabet
	END
		ELSE
		BEGIN
			select @fldId =ISNULL(max(fldId),0)+1 from  [Com].tblComputationFormula 
			INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
			SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update Drd.tblParametreSabet
			Set fldFormulId=@fldId
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
		END
	END
	
	if(@fieldname='FormulArchiveProperties')
	BEGIN
	declare @FormulArchive int=0
	SELECT @FormulArchive=fldFormulId FROM Arch.tblProperties WHERE fldid=@id
	IF( @FormulArchive IS NOT NULL and @FormulArchive=0)
	BEGIN
			UPDATE Com.tblComputationFormula
			SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
			WHERE  [fldId] = @ParametrSabet
	END
		ELSE
		BEGIN
			select @fldId =ISNULL(max(fldId),0)+1 from  [Com].tblComputationFormula 
			INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
			SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update Arch.tblProperties
			Set fldFormulId=@fldId
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
		END
	END

	if(@fieldname='FormulDarmadGroup')
	BEGIN
	SELECT @DaramdGroup=fldFormuleId FROM Drd.tblDaramadGroup_Parametr WHERE fldid=@id
	IF( @DaramdGroup IS NOT NULL)
	BEGIN
			UPDATE Com.tblComputationFormula
			SET   [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
			WHERE  [fldId] = @DaramdGroup
	END
		ELSE
		BEGIN
			select @fldId =ISNULL(max(fldId),0)+1 from  [Com].tblComputationFormula 
			INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
			SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update Drd.tblDaramadGroup_Parametr
			Set fldFormuleId=@fldId
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
		END
	end
	
	
	ELSE IF(@fieldname='') 
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblComputationFormula] 
	INSERT INTO  [Com].[tblComputationFormula] ([fldId], [fldType], [fldFormule], [fldOrganId], [fldLibrary],fldAzTarikh, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldType, @fldFormule, @fldOrganId, @fldLibrary,@fldAzTarikh, @fldUserId, @fldDesc, GETDATE()
	END
	commit















GO
