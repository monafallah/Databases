SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankTemplate_HeaderInsert] 
   
    @fldNamePattern nvarchar(200),
    @fldStartRow smallint,
	@Details [ACC].[BankTemplate_Details] READONLY,
    @fldDesc nvarchar(200),
    @fldIP varchar(16),
    @fldUserId int,
	@fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5)
AS 
	 
	
	BEGIN TRAN
declare @fldid int ,@fileId int
	select @fileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	if (@@error<>0)
		rollback
	else
		begin
		select @fldid=isnull(max(fldId),0)+1  FROM   [ACC].[tblBankTemplate_Header] 
		INSERT INTO [ACC].[tblBankTemplate_Header] ([fldId], [fldNamePattern], [fldStartRow], [fldDesc], [fldDate], [fldIP], [fldUserId],fldFileId)
		SELECT @fldId, @fldNamePattern, @fldStartRow, @fldDesc, getdate(), @fldIP, @fldUserId,@fileId
	
		if (@@error<>0)
			rollback
		else
		begin
			declare @fldDetailid int
			select @fldDetailid=isnull(max(fldId),0)  FROM   [ACC].[tblBankTemplate_Details] 
			INSERT INTO [ACC].[tblBankTemplate_Details] ([fldId], [fldHeaderId], [fldBankId])
			SELECT @fldDetailid+ROW_NUMBER() over(order by BankId), @fldid, BankId from @Details
		end
	end			
               
	COMMIT
GO
