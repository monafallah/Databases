SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblletterTemplateUpdate] 
    @fldId int,
    @fldName nvarchar(300),
    @fldIsBackGround bit,
    @fldFileId int ,
	@fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
	@fldMergeFieldId nvarchar(800),
	@fldLetterFile varbinary (max),
	@fldLetterPasvand varchar(5),
	@fldLetterFileId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @flag bit=0,@MergeField_LetterTemplateId int
	
	if (@fldFileId is null and @fldImage is not null)/*insert*/
	begin
		select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldFileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
		begin
			ROLLBACK
			set @flag=1
		end
	end
	else if (@fldFileId is not null and @fldImage is not null)/*update*/
	begin
		update [Com].[tblFile]
		set fldImage=@fldImage,fldPasvand=@fldPasvand,fldUserId=@fldUserId,fldDate=GETDATE()
		where fldid=@fldFileId

	end
	else if (@fldFileId is not  null and @fldImage is  null)/*delete*/
	begin
		delete from com.tblfile
		where fldid=@fldFileId
		if (@@ERROR<>0)
		begin
			ROLLBACK
			set @flag=1
		end
		set @fldFileId= null
	end


-----------------------
if (@fldLetterFileId is null and @fldLetterFile is not null)/*insert*/
	begin
		select @fldLetterFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldLetterFileId, @fldLetterFile,@fldLetterPasvand, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
		begin
			ROLLBACK
			set @flag=1
		end
	end
	else if (@fldLetterFileId is not null and @fldLetterFile is not null)/*update*/
	begin
		update [Com].[tblFile]
		set fldImage=@fldLetterFile,fldPasvand=@fldLetterPasvand,fldUserId=@fldUserId,fldDate=GETDATE()
		where fldid=@fldLetterFileId

	end
	else if (@fldLetterFileId is not  null and @fldLetterFile is  null)/*delete*/
	begin
		delete from com.tblfile
		where fldid=@fldLetterFileId
		if (@@ERROR<>0)
		begin
			ROLLBACK
			set @flag=1
		end
		set @fldLetterFileId= null
	end


	if (@flag=0)
	begin

	UPDATE [Auto].[tblletterTemplate]
	SET    [fldName] = @fldName, [fldIsBackGround] = @fldIsBackGround, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	,fldletterFileId=@fldLetterFileId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   
	else 
		begin
			delete from [Auto].[tblMergeField_LetterTemplate] 
			where fldLetterTamplateId=@fldId
			if(@@Error<>0)
				rollback  
			else
				begin
				select @MergeField_LetterTemplateId =ISNULL(max(fldId),0) from [Auto].[tblMergeField_LetterTemplate] 
				INSERT INTO [Auto].[tblMergeField_LetterTemplate] ([fldId], [fldLetterTamplateId], [fldMergeFieldId], [fldUserId], [fldOrganId], [fldDesc], [fldIP], [fldDate])
				SELECT @MergeField_LetterTemplateId+row_number()over (order by item), @fldId, item, @fldUserId, @fldOrganId, @fldDesc, @fldIP, getdate()
				from com.split(@fldMergeFieldId,',')
				if(@@Error<>0)
					rollback 
				end 

		end
	end
	COMMIT
GO
