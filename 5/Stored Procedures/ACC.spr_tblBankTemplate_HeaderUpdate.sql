SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankTemplate_HeaderUpdate] 
    @fldId int,
    @fldNamePattern nvarchar(200),
    @fldStartRow smallint,
	@Details [ACC].[BankTemplate_Details] READONLY,
    @fldDesc nvarchar(200),
    @fldIP varchar(16),
    @fldUserId int,
	@fldFileId int ,
	@fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5)
AS 
	 
	
	BEGIN TRAN

	if (@fldFileId is null and @fldImage is not null)/*insert*/
	begin
		select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldFileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
		if (@@ERROR<>0)
		begin
			ROLLBACK
		end
	end
	else if (@fldFileId is not null and @fldImage is not null)/*update*/
	begin
		update [Com].[tblFile]
		set fldImage=@fldImage,fldPasvand=@fldPasvand,fldUserId=@fldUserId,fldDate=GETDATE()
		where fldid=@fldFileId

	end
	

	UPDATE [ACC].[tblBankTemplate_Header]
	SET    [fldNamePattern] = @fldNamePattern, [fldStartRow] = @fldStartRow, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback
		else
	begin
		delete d FROM [ACC].[tblBankTemplate_Details] as d
		left join @Details as t on t.BankId=d.fldBankId
		where d.fldHeaderId=@fldId and t.BankId is null
		if (@@error<>0)
		rollback

		UPDATE d SET  [fldBankId] = t.BankId
		from[ACC].[tblBankTemplate_Details] as d
		inner join  @Details as t on t.Id=d.fldId		
		if (@@error<>0)
			rollback

		declare @fldDetailid int
		select @fldDetailid=isnull(max(fldId),0)  FROM   [ACC].[tblBankTemplate_Details] 
		INSERT INTO [ACC].[tblBankTemplate_Details] ([fldId], [fldHeaderId], [fldBankId])
		SELECT @fldDetailid+ROW_NUMBER() over(order by BankId), @fldid, BankId from @Details
		where Id =0
		if (@@error<>0)
		rollback

		
	end


	COMMIT
GO
