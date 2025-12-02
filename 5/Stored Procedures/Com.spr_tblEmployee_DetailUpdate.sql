SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployee_DetailUpdate] 
    @fldId int,
    @fldEmployeeId int,
    @fldFatherName nvarchar(60),
    @fldJensiyat bit,
    @fldTarikhTavalod nvarchar(10),
    @fldMadrakId int,
    @fldNezamVazifeId TINYINT,
    @fldTaaholId int,
    @fldReshteId int,
    @fldFileId int,
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldSh_Shenasname nvarchar(10),
    @fldMahalTavalodId int,
    @fldMahalSodoorId int,
    @fldTarikhSodoor nvarchar(10),
    @fldAddress nvarchar(MAX),
    @fldCodePosti nvarchar(50),
    @fldMeliyat bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTel varchar(20),
	@fldMobile varchar(20)
AS 
	BEGIN TRAN
	DECLARE @ImageId INT,@flag BIT=0
	IF(@fldFileId =0 AND @fldFile IS NOT NULL)
	BEGIN
		select @ImageId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO Com.tblFile
	        ( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
		SELECT @ImageId,@fldFile,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	UPDATE [Com].[tblEmployee_Detail]
	SET   [fldEmployeeId] = @fldEmployeeId, [fldFatherName] = @fldFatherName, [fldJensiyat] = @fldJensiyat,
	 [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId,
	  [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteId, [fldFileId] = @ImageId, [fldSh_Shenasname] = @fldSh_Shenasname,
	   [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahalSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor,
	    [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId,
		 [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldTel=@fldTel,fldMobile=@fldMobile
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	ROLLBACK
	END
	end
	ELSE IF(@fldFileId <>0 AND @fldFile IS NULL)
	
	UPDATE [Com].[tblEmployee_Detail]
	SET    [fldId] = @fldId, [fldEmployeeId] = @fldEmployeeId, [fldFatherName] = @fldFatherName, [fldJensiyat] = @fldJensiyat,
	 [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId,
	  [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteId, [fldFileId] = @fldFileId, [fldSh_Shenasname] = @fldSh_Shenasname,
	   [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahalSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor,
	    [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId,
		 [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldTel=@fldTel,fldMobile=@fldMobile
	WHERE  [fldId] = @fldId
	
	ELSE
	BEGIN
			UPDATE Com.tblFile
			SET fldImage=@fldFile,fldPasvand=@fldPasvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
			WHERE fldid=@fldFileId
			IF(@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END
		IF(@flag=0)
		BEGIN
			UPDATE [Com].[tblEmployee_Detail]
			SET    [fldId] = @fldId, [fldEmployeeId] = @fldEmployeeId, [fldFatherName] = @fldFatherName, [fldJensiyat] = @fldJensiyat,
			 [fldTarikhTavalod] = @fldTarikhTavalod, [fldMadrakId] = @fldMadrakId, [fldNezamVazifeId] = @fldNezamVazifeId, 
			 [fldTaaholId] = @fldTaaholId, [fldReshteId] = @fldReshteId, [fldFileId] = @fldFileId, [fldSh_Shenasname] = @fldSh_Shenasname,
			  [fldMahalTavalodId] = @fldMahalTavalodId, [fldMahalSodoorId] = @fldMahalSodoorId, [fldTarikhSodoor] = @fldTarikhSodoor,
			   [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldMeliyat] = @fldMeliyat, [fldUserId] = @fldUserId,
			    [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldTel=@fldTel,fldMobile=@fldMobile
			WHERE  [fldId] = @fldId
			IF(@@ERROR<>0)
			ROLLBACK
		END
	END
	if not exists (select  * from com.tblHistoryTahsilat where fldEmployeeId=@fldEmployeeId)
	begin
		select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblHistoryTahsilat] 
				INSERT INTO [Com].[tblHistoryTahsilat] ([fldId], [fldEmployeeId], [fldMadrakId], [fldReshteId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
				SELECT @fldId, @fldEmployeeId, @fldMadrakId, @fldReshteId, dbo.Fn_AssembelyMiladiToShamsi( GETDATE()), @fldUserId, @fldDesc,  GETDATE()
				if (@@ERROR<>0)
					ROLLBACK
	end
	else
	begin
		declare @id int
		select top 1 @id=fldId from [Com].[tblHistoryTahsilat]
			where fldEmployeeId=@fldEmployeeId
			order by fldTarikh desc

		UPDATE [Com].[tblHistoryTahsilat]
		SET    [fldEmployeeId] = @fldEmployeeId, [fldMadrakId] = @fldMadrakId, [fldReshteId] = @fldReshteId,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =  GETDATE()
		WHERE  [fldId] = @id
		if (@@ERROR<>0)
			ROLLBACK
		
	end
	COMMIT TRAN
GO
