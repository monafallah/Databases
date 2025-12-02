SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblletterTemplateInsert] 
   
    @fldName nvarchar(300),
    @fldIsBackGround bit,
    @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
	@fldMergeFieldId nvarchar(800),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldLetterFile varbinary (max),
	@fldLetterPasvand varchar(5),
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int , @fldFileId int = NULL,@flag bit=0,@MergeField_LetterTemplateId int,@fileletter int=NULL
	if (@fldImage is not null)
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
	if (@fldLetterFile is not null)
	begin 
		select @fileletter =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fileletter, @fldLetterFile,@fldLetterPasvand, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
		begin
			ROLLBACK
			set @flag=1
		end
	end

	if (@flag=0)
	begin
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblletterTemplate] 
	INSERT INTO [Auto].[tblletterTemplate] ([fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldFormat,fldLetterFileId)
	SELECT @fldId, @fldName, @fldIsBackGround, @fldFileId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP,'',@fileletter
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
	COMMIT
GO
