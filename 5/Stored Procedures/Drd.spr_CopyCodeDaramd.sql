SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CopyCodeDaramd] (@fieldName NVARCHAR(50), @mabdaId INT,@maghsadId INT,@userId INT)
as
--DECLARE @mabdaId INT,@maghsadId INT,@userId INT
DECLARE @ParamId INT,@FormuleParamId INT,@IdFormule INT,@IdNerkh INT,@IdLetterMinut INT,@FileReportId INT,@fileId INT,@idroonevesht INT,@formulKoliId INT,@fldIdFormule INT,@FormuleMohasebatId INT,@IdMohasebat INT
DECLARE @flag BIT=0
DECLARE @t TABLE (id INT)
IF(@fieldName='Koli')
BEGIN
	-------parametr sabet formule
	IF EXISTS(SELECT * FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId AND fldFormulId IS NOT NULL)
	BEGIN
		
			INSERT INTO @t( id )
			SELECT fldFormulId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId 
			SELECT @FormuleParamId =ISNULL(max(fldId),0)+1 from com.tblComputationFormula 
			INSERT INTO Com.tblComputationFormula(fldId , fldType ,fldFormule ,fldOrganId ,fldLibrary ,fldAzTarikh ,fldUserId ,fldDesc ,fldDate)
			SELECT @FormuleParamId+ROW_NUMBER() OVER (ORDER BY fldid),fldType,fldFormule,fldOrganId,fldLibrary,fldAzTarikh,@userId,(SELECT fldId FROM Drd.tblParametreSabet WHERE fldFormulId IN (SELECT id FROM @t)) ,GETDATE() FROM Com.tblComputationFormula
			WHERE fldId IN (SELECT id FROM @t)
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK 
				SET @flag=1
			END
	END
	-------parametr sabet
	IF(@flag=0)
	BEGIN
		SELECT @ParamId =ISNULL(max(fldId),0)+1 from Drd.tblParametreSabet
		INSERT INTO Drd.tblParametreSabet( fldId ,fldShomareHesabCodeDaramadId ,fldNameParametreFa ,fldNameParametreEn ,fldNoe ,fldNoeField ,fldFormulId ,fldVaziyat ,fldComboBaxId ,fldUserId ,fldDesc ,fldDate ,fldTypeParametr,fldDescCopy)
		SELECT @ParamId+ROW_NUMBER()OVER (ORDER BY fldId),@maghsadId,fldNameParametreFa,fldNameParametreEn,fldNoe,fldNoeField,ISNULL((SELECT fldId FROM Com.tblComputationFormula WHERE fldDesc=tblParametreSabet.fldId),fldFormulId),fldVaziyat,fldComboBaxId,@userId,fldDesc,GETDATE(),fldTypeParametr,fldid FROM Drd.tblParametreSabet
		WHERE fldShomareHesabCodeDaramadId=@mabdaId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	--------nerkh parametr sabet
	IF(@flag=0)
	BEGIN
		SELECT @IdNerkh =ISNULL(max(fldId),0)+1 from Drd.tblParametreSabet_Nerkh
		INSERT INTO Drd.tblParametreSabet_Nerkh( fldId ,fldParametreSabetId ,fldTarikhFaalSazi , fldValue ,fldUserId ,fldDesc ,fldDate )
		SELECT @IdNerkh+ROW_NUMBER()OVER (ORDER BY fldId),(SELECT top(1) fldId FROM Drd.tblParametreSabet WHERE fldDescCopy=fldParametreSabetId) ,fldTarikhFaalSazi,fldValue,@userId,fldDesc,getdate() FROM Drd.tblParametreSabet_Nerkh
		WHERE fldParametreSabetId IN (SELECT fldId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId)
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	-------letter minute
	IF(@flag=0)
	BEGIN
		SELECT @IdNerkh =ISNULL(max(fldId),0)+1 from Drd.tblLetterMinut
		INSERT INTO Drd.tblLetterMinut(fldId ,fldShomareHesabCodeDaramadId ,fldTitle,fldDescMinut ,fldUserId,fldDate,fldDesc,fldSodoorBadAzVarizNaghdi ,fldSodoorBadAzTaghsit,fldTanzimkonande)
		SELECT @IdNerkh+ROW_NUMBER()OVER (ORDER BY fldId),@maghsadId,fldTitle,fldDescMinut,@userId,GETDATE(),fldDesc,fldSodoorBadAzVarizNaghdi,fldSodoorBadAzTaghsit,fldTanzimkonande
		FROM Drd.tblLetterMinut WHERE fldShomareHesabCodeDaramadId=@mabdaId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	-------sharh code
	IF(@flag=0)
	BEGIN
		UPDATE Drd.tblShomareHesabCodeDaramad
		SET fldSharhCodDaramd=(SELECT fldSharhCodDaramd FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@mabdaId),fldUserId=@userId
		WHERE fldid=@maghsadId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	-------report 
	
		SELECT @FileReportId=fldReportFileId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@mabdaId
		IF(@FileReportId IS NOT NULL)
		BEGIN
		IF(@flag=0)
		BEGIN
			SELECT @fileId =ISNULL(max(fldId),0)+1 from Com.tblFile
			INSERT INTO Com.tblFile( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
			SELECT @fileId,fldImage,fldPasvand,@userId,fldDesc,GETDATE() FROM Com.tblFile
			WHERE fldId=@FileReportId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		end
		IF(@flag=0)
			BEGIN
				UPDATE Drd.tblShomareHesabCodeDaramad
				SET fldReportFileId=@fileId
				WHERE fldid=@maghsadId
				IF(@@ERROR<>0)
				BEGIN
					ROLLBACK
					SET @flag=1
				END
			end
		END


	------roonevesht
	IF(@flag=0)
	BEGIN
		SELECT @idroonevesht =ISNULL(max(fldId),0)+1 from Drd.tblRoonevesht
		INSERT INTO Drd.tblRoonevesht(fldId ,fldShomareHesabCodeDaramadId ,fldTitle ,fldUserId ,fldDate ,fldDesc)
		SELECT @idroonevesht+ROW_NUMBER()OVER (ORDER BY fldId),@maghsadId,fldTitle,@userId,GETDATE(),fldDesc FROM Drd.tblRoonevesht 
		WHERE fldShomareHesabCodeDaramadId=@mabdaId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	------Formul Koli
	
	SELECT @formulKoliId=fldFormulKoliId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@mabdaId
	IF(@formulKoliId IS NOT NULL)
	BEGIN
		IF(@flag=0)
		BEGIN
			SELECT @fldIdFormule =ISNULL(max(fldId),0)+1 from Com.tblComputationFormula
			INSERT INTO Com.tblComputationFormula( fldId ,fldType ,fldFormule ,fldOrganId ,fldLibrary ,fldAzTarikh ,fldUserId ,fldDesc ,fldDate )
			SELECT @fldIdFormule,fldType,fldFormule,fldOrganId,fldLibrary,fldAzTarikh,@userId,fldDesc,GETDATE() FROM Com.tblComputationFormula
			WHERE fldId=@formulKoliId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		end
		IF(@flag=0)
		BEGIN
			UPDATE Drd.tblShomareHesabCodeDaramad
			SET fldFormulKoliId=@fldIdFormule,fldUserId=@userId
			WHERE fldId=@maghsadId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
	end
	------formule mohasebat

	SELECT @FormuleMohasebatId=fldFormulMohasebatId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@mabdaId
	IF(@FormuleMohasebatId IS NOT NULL)
	BEGIN
		IF(@flag=0)
		BEGIN
			SELECT @IdMohasebat =ISNULL(max(fldId),0)+1 from Com.tblComputationFormula
			INSERT INTO Com.tblComputationFormula( fldId ,fldType ,fldFormule ,fldOrganId ,fldLibrary ,fldAzTarikh ,fldUserId ,fldDesc ,fldDate )
			SELECT @IdMohasebat,fldType,fldFormule,fldOrganId,fldLibrary,fldAzTarikh,@userId,fldDesc,GETDATE() FROM Com.tblComputationFormula
			WHERE fldId=@FormuleMohasebatId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
	IF(@flag=0)
		BEGIN
			UPDATE Drd.tblShomareHesabCodeDaramad
			SET fldFormulMohasebatId=@IdMohasebat,fldUserId=@userId
			WHERE fldId=@maghsadId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		end
	END
	------formule saz
	IF(@flag=0)
	BEGIN
		UPDATE Drd.tblShomareHesabCodeDaramad
		SET fldFormolsaz=(SELECT fldFormolsaz FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@mabdaId),fldUserId=@userId
		WHERE fldid=@maghsadId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
	IF (@flag=0)
	BEGIN
		UPDATE Com.tblComputationFormula
		SET fldDesc=''
		WHERE fldid IN (SELECT fldFormulId FROM Drd.tblParametreSabet WHERE fldFormulId=tblComputationFormula.fldId AND fldShomareHesabCodeDaramadId=@maghsadId)
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	END
END
IF(@fieldName='Parametr')
BEGIN
	-------parametr sabet formule
	IF EXISTS(SELECT * FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId AND fldFormulId IS NOT NULL)
	BEGIN
			IF(@flag=0)
			BEGIN
				INSERT INTO @t( id )
				SELECT fldFormulId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId 
				SELECT @FormuleParamId =ISNULL(max(fldId),0)+1 from com.tblComputationFormula 
				INSERT INTO Com.tblComputationFormula(fldId , fldType ,fldFormule ,fldOrganId ,fldLibrary ,fldAzTarikh ,fldUserId ,fldDesc ,fldDate)
				SELECT @FormuleParamId+ROW_NUMBER() OVER (ORDER BY fldid),fldType,fldFormule,fldOrganId,fldLibrary,fldAzTarikh,@userId,(SELECT fldId FROM Drd.tblParametreSabet WHERE fldFormulId IN (SELECT id FROM @t)) ,GETDATE() FROM Com.tblComputationFormula
				WHERE fldId IN (SELECT id FROM @t)
				IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		end
	end
	-------parametr sabet
	IF(@flag=0)
	BEGIN
			SELECT @ParamId =ISNULL(max(fldId),0)+1 from Drd.tblParametreSabet
			INSERT INTO Drd.tblParametreSabet( fldId ,fldShomareHesabCodeDaramadId ,fldNameParametreFa ,fldNameParametreEn ,fldNoe ,fldNoeField ,fldFormulId ,fldVaziyat ,fldComboBaxId ,fldUserId ,fldDesc ,fldDate ,fldTypeParametr,fldDescCopy)
			SELECT @ParamId+ROW_NUMBER()OVER (ORDER BY fldId),@maghsadId,fldNameParametreFa,fldNameParametreEn,fldNoe,fldNoeField,ISNULL((SELECT fldId FROM Com.tblComputationFormula WHERE fldDesc=tblParametreSabet.fldId),fldFormulId),fldVaziyat,fldComboBaxId,@userId,flddesc,GETDATE(),fldTypeParametr,fldid FROM Drd.tblParametreSabet
			WHERE fldShomareHesabCodeDaramadId=@mabdaId
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
	end
	--------nerkh parametr sabet
	IF(@flag=0)
		BEGIN
			SELECT @IdNerkh =ISNULL(max(fldId),0)+1 from Drd.tblParametreSabet_Nerkh
			INSERT INTO Drd.tblParametreSabet_Nerkh( fldId ,fldParametreSabetId ,fldTarikhFaalSazi , fldValue ,fldUserId ,fldDesc ,fldDate )
			SELECT @IdNerkh+ROW_NUMBER()OVER (ORDER BY fldId),(SELECT fldId FROM Drd.tblParametreSabet WHERE fldDescCopy=fldParametreSabetId) ,fldTarikhFaalSazi,fldValue,@userId,fldDesc,GETDATE() FROM Drd.tblParametreSabet_Nerkh
			WHERE fldParametreSabetId IN (SELECT fldId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@mabdaId)
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
		END
	IF(@flag=0)
	BEGIN
		UPDATE Com.tblComputationFormula
		SET fldDesc=''
		WHERE fldid IN (SELECT fldFormulId FROM Drd.tblParametreSabet WHERE fldFormulId=tblComputationFormula.fldId AND fldShomareHesabCodeDaramadId=@maghsadId)
		IF(@@ERROR<>0)
			BEGIN
				ROLLBACK
				SET @flag=1
			END
	END
END
GO
