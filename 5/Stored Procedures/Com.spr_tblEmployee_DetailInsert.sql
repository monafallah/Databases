SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployee_DetailInsert] 

    @fldEmployeeId int,
    @fldFatherName nvarchar(60),
    @fldJensiyat bit,
    @fldTarikhTavalod nvarchar(10),
    @fldMadrakId int,
    @fldNezamVazifeId TINYINT,
    @fldTaaholId int,
    @fldReshteId int,
    @fldFile VARBINARY(max),
    @fldPassvand NVARCHAR(5),
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
	SET @fldFatherName =com.fn_TextNormalize(@fldFatherName)
	SET @fldAddress =com.fn_TextNormalize(@fldAddress)
	SET @fldDesc =com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@fldFileId INT,@flag BIT=0
	select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO Com.tblFile
	        ( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
SELECT @fldFileId,@fldFile,@fldPassvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblEmployee_Detail] 
	INSERT INTO [Com].[tblEmployee_Detail] ([fldId], [fldEmployeeId], [fldFatherName], [fldJensiyat],
	 [fldTarikhTavalod], [fldMadrakId], [fldNezamVazifeId], [fldTaaholId], [fldReshteId], [fldFileId], 
	 [fldSh_Shenasname], [fldMahalTavalodId], [fldMahalSodoorId], [fldTarikhSodoor], [fldAddress], [fldCodePosti],
	  [fldMeliyat], [fldUserId], [fldDesc], [fldDate],fldtel,fldmobile)
	SELECT @fldId, @fldEmployeeId, @fldFatherName, @fldJensiyat, @fldTarikhTavalod, @fldMadrakId,
	 @fldNezamVazifeId, @fldTaaholId, @fldReshteId, @fldFileId, @fldSh_Shenasname, @fldMahalTavalodId,
	 @fldMahalSodoorId, @fldTarikhSodoor, @fldAddress, @fldCodePosti, @fldMeliyat, @fldUserId, @fldDesc, GETDATE(),@fldTel,@fldMobile
	if (@@ERROR<>0)
		ROLLBACK
	else 
	begin
		select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblHistoryTahsilat] 
				INSERT INTO [Com].[tblHistoryTahsilat] ([fldId], [fldEmployeeId], [fldMadrakId], [fldReshteId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
				SELECT @fldId, @fldEmployeeId, @fldMadrakId, @fldReshteId, dbo.Fn_AssembelyMiladiToShamsi( GETDATE()), @fldUserId, @fldDesc,  GETDATE()
				if (@@ERROR<>0)
					ROLLBACK
	end
	
	begin
		select top 1 @fldMadrakId=fldMadrakId,@fldReshteId=fldReshteId from [Com].[tblHistoryTahsilat]
		where fldEmployeeId=@fldEmployeeId
		order by fldTarikh desc
		update com.tblEmployee_Detail set fldMadrakId=@fldMadrakId,fldReshteId=@fldReshteId
		where fldEmployeeId=@fldEmployeeId
	end
	end
	COMMIT
GO
