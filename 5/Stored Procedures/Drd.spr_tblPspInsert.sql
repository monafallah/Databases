SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPspInsert] 
    @fldFile varbinary(MAX),
	@fldPasvand NVARCHAR(5),
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @flag bit=0 ,@fldIDD int,@fldFileId int
	select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldFileId, @fldFile,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
	 begin
	   set @flag=1
	   ROLLBACK
	 end
	 if(@flag=0)
	 begin

	select @fldIDD =ISNULL(max(fldId),0)+1 from [Drd].[tblPsp] 
	INSERT INTO [Drd].[tblPsp] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate], [fldFileId])
	SELECT @fldIDD, @fldTitle, @fldUserId, @fldDesc, getdate(), @fldFileId
	if (@@ERROR<>0)
		BEGIN
			  Set @flag=1
			  Rollback
		  END
      end

	COMMIT
GO
