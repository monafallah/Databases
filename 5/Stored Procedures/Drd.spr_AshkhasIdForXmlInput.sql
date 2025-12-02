SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_AshkhasIdForXmlInput](@type TINYINT,@UserId INT,@CodeMeli NVARCHAR(50),@Name NVARCHAR(300),@family NVARCHAR(100),@shomareSabt NVARCHAR(50),@TypeShakhs TINYINT)
AS
DECLARE  @IdOutput INT=0,@id INT,@fldIDHaghighi INT
,@flag BIT=0
IF(@type=1)/*اشخاص حقیقی*/
BEGIN
	SELECT  @id=fldId FROM Com.tblEmployee WHERE fldName=@Name AND fldfamily=@family AND fldCodemeli=@CodeMeli
	SELECT @IdOutput=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@id
	IF(@IdOutput=0)
	BEGIN
		IF(LEN(@CodeMeli)=10)/*اتباع داخلی*/
		BEGIN
			select @fldIDHaghighi =ISNULL(max(fldId),0)+1 from [Com].[tblEmployee] 
			INSERT INTO Com.tblEmployee( fldId ,fldName ,fldFamily ,fldCodemeli ,fldStatus ,fldUserId ,fldDesc ,fldDate ,fldTypeShakhs)
			SELECT @fldIDHaghighi,@Name,@family,@codeMeli,0,@UserId,'',GETDATE(),0
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK 
				SET @flag=1
			END
			IF(@flag =0)
			BEGIN
				select @IdOutput =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhas] 
				INSERT INTO Com.tblAshkhas( fldId ,fldHaghighiId ,fldHoghoghiId ,fldUserId ,fldDesc ,fldDate)
				SELECT @IdOutput,@fldIDHaghighi,NULL,@UserId,'',GETDATE()
			END
		END
		ELSE/*اتباع خارجی*/
		BEGIN
			select @fldIDHaghighi =ISNULL(max(fldId),0)+1 from [Com].[tblEmployee] 
			INSERT INTO Com.tblEmployee( fldId ,fldName ,fldFamily ,fldCodemeli ,fldStatus ,fldUserId ,fldDesc ,fldDate ,fldTypeShakhs)
			SELECT @fldIDHaghighi,@Name,@family,@codeMeli,0,@UserId,'',GETDATE(),1
			IF(@@ERROR<>0)
			BEGIN
				ROLLBACK 
				SET @flag=1
			END
			IF(@flag=0)
			BEGIN
				select @IdOutput =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhas] 
				INSERT INTO Com.tblAshkhas( fldId ,fldHaghighiId ,fldHoghoghiId ,fldUserId ,fldDesc ,fldDate)
				SELECT @IdOutput,@fldIDHaghighi,NULL,@UserId,'',GETDATE()
			END
		END
	END
END
ELSE IF(@type=2)/*اشخاص حقوقی*/
BEGIN
	SELECT @id=fldid  FROM Com.tblAshkhaseHoghoghi WHERE fldName=@Name AND fldShenaseMelli=@CodeMeli AND fldShomareSabt=@shomareSabt AND fldTypeShakhs=@TypeShakhs
	SELECT @IdOutput=fldId FROM Com.tblAshkhas WHERE fldHoghoghiId=@id
	IF(@IdOutput=0)
	BEGIN
		select @fldIDHaghighi =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhaseHoghoghi] 
		INSERT INTO Com.tblAshkhaseHoghoghi(fldId ,fldShenaseMelli ,fldName , fldShomareSabt ,fldUserId , fldDesc ,fldDate ,fldTypeShakhs ,fldSayer)
		SELECT @fldIDHaghighi,@CodeMeli,@Name,@shomareSabt,@UserId,'',GETDATE(),@TypeShakhs,1
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK 
			SET @flag=1
		END
		IF(@flag =0)
		BEGIN
			select @IdOutput =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhas] 
			INSERT INTO Com.tblAshkhas( fldId ,fldHaghighiId ,fldHoghoghiId ,fldUserId ,fldDesc ,fldDate)
			SELECT @IdOutput,NULL,@fldIDHaghighi,@UserId,'',GETDATE()
		END
	end
END
ELSE IF(@type=0)/*سایر*/
BEGIN
	SELECT @id=fldid  FROM Com.tblAshkhaseHoghoghi WHERE fldName=@Name AND fldTypeShakhs=@TypeShakhs
	SELECT @IdOutput=fldId FROM Com.tblAshkhas WHERE fldHoghoghiId=@id
	IF(@IdOutput=0)
	BEGIN
		select @fldIDHaghighi =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhaseHoghoghi] 
		INSERT INTO Com.tblAshkhaseHoghoghi(fldId ,fldShenaseMelli ,fldName , fldShomareSabt ,fldUserId , fldDesc ,fldDate ,fldTypeShakhs ,fldSayer)
		SELECT @fldIDHaghighi,'',@Name,NULL,@UserId,'',GETDATE(),@TypeShakhs,2
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK 
			SET @flag=1
		END
		IF(@flag =0)
		BEGIN
			select @IdOutput =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhas] 
			INSERT INTO Com.tblAshkhas( fldId ,fldHaghighiId ,fldHoghoghiId ,fldUserId ,fldDesc ,fldDate)
			SELECT @IdOutput,NULL,@fldIDHaghighi,@UserId,'',GETDATE()
		END
	end
END

SELECT @IdOutput AS IdOutput
GO
