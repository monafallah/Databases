SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_tblUpdateFileForCodhayeDaramd]
   @fldShomareHesabCodeDaramadId INT,
    @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
    @fldUserId INT,
    @fldDesc nvarchar(MAX)
as 
  BEGIN TRAN
   declare @fldId int ,@flag bit=0,@fldReportFileId INT
   
    select @fldReportFileId=fldReportFileId
    from Drd.tblShomareHesabCodeDaramad
	where fldId= @fldShomareHesabCodeDaramadId

	if (@fldReportFileId is null)
	BEGIN
    select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	if(@@ERROR<>0)
		BEGIN
	   Set @flag=1
	   Rollback
		END
		if(@flag=0)
		Begin 
		UPDATE [Drd].[tblShomareHesabCodeDaramad]
		SET   [fldReportFileId]=@fldID
		WHERE   [fldId] = @fldShomareHesabCodeDaramadId
		if(@@Error<>0)
		begin
			 set @flag=1
			 Rollback
		end
		ENd
	end

	 IF(@fldReportFileId is not null)
	UPDATE [Com].[tblFile]
	SET    [fldImage] = @fldImage, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldPasvand=@fldPasvand
	where fldId=@fldReportFileId

COMMIT
GO
