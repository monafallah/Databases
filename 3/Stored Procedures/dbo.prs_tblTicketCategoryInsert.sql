SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketCategoryInsert] 
  
    @fldTitle nvarchar(150),
	@fldType BIT,
   
    @fldDesc nvarchar(100),
	@fldInputId INT ,
    @fldJsonParametr nvarchar(2000)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	Declare  @fldRowId varbinary(8)
	SET @fldDesc =dbo.fn_TextNormalize(@fldDesc) 
	SET @fldTitle =dbo.fn_TextNormalize(@fldTitle) 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTicketCategory] 
	INSERT INTO [dbo].[tblTicketCategory] ([fldId], [fldTitle],fldType, [fldDesc],fldOrder)
	SELECT @fldId, @fldTitle,@fldType, @fldDesc,@fldId
	if (@@ERROR<>0)
	begin	
		rollback
		
	end
	else
	begin
		select @fldRowId=tblTicketCategory.%%physLoc%% from tblTicketCategory WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@fldInputId ,
													1 ,
													1 ,
													'tblTicketCategory' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end

	COMMIT

GO
