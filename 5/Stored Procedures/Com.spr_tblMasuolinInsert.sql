SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolinInsert] 

    @fldTarikhEjra CHAR(10),
    @fldModule_OrganId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRANSACTION
	DECLARE @fldId INT ,@flag BIT=0,@DetailId INT
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin] 
	INSERT INTO [Com].[tblMasuolin] ([fldId], [fldTarikhEjra], [fldModule_OrganId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTarikhEjra, @fldModule_OrganId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
	BEGIN
	SET @flag=1
	ROLLBACK
	END
	IF(@flag=0)
	BEGIN
		SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
		INSERT INTO Com.tblMasuolin_Detail( fldId ,fldEmployId ,fldOrganPostId ,fldMasuolinId ,fldOrderId ,fldUserId ,fldDesc ,fldDate)
		SELECT @DetailId,NULL,NULL,@fldId,1,@fldUserId,@fldDesc,GETDATE()
		if (@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END
		IF(@flag=0)
		BEGIN	
		SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
		INSERT INTO Com.tblMasuolin_Detail( fldId ,fldEmployId ,fldOrganPostId ,fldMasuolinId ,fldOrderId ,fldUserId ,fldDesc ,fldDate)
		SELECT @DetailId,NULL,NULL,@fldId,2,@fldUserId,@fldDesc,GETDATE()
		if (@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END
		END
		IF(@flag=0)
		BEGIN
		SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
		INSERT INTO Com.tblMasuolin_Detail( fldId ,fldEmployId ,fldOrganPostId ,fldMasuolinId ,fldOrderId ,fldUserId ,fldDesc ,fldDate)
		SELECT @DetailId,NULL,NULL,@fldId,3,@fldUserId,@fldDesc,GETDATE()
			if (@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END	
		END
		IF(@flag=0)
		BEGIN
		SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
		INSERT INTO Com.tblMasuolin_Detail( fldId ,fldEmployId ,fldOrganPostId ,fldMasuolinId ,fldOrderId ,fldUserId ,fldDesc ,fldDate)
		SELECT @DetailId,NULL,NULL,@fldId,4,@fldUserId,@fldDesc,GETDATE()
			if (@@ERROR<>0)
			BEGIN
			SET @flag=1
			ROLLBACK
			END
		END
		IF(@flag=0)
		BEGIN
		SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
		INSERT INTO Com.tblMasuolin_Detail( fldId ,fldEmployId ,fldOrganPostId ,fldMasuolinId ,fldOrderId ,fldUserId ,fldDesc ,fldDate)
		SELECT @DetailId,NULL,NULL,@fldId,5,@fldUserId,@fldDesc,GETDATE()
		end
	end
	COMMIT
GO
