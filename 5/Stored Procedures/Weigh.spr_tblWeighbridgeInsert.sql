SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblWeighbridgeInsert] 
   
    @fldAshkhasHoghoghiId int,
    @fldName nvarchar(150),
    @fldAddress nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16),
	@fldPassword nvarchar(50)
AS 

	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblWeighbridge] 

	INSERT INTO [Weigh].[tblWeighbridge] ([fldId], [fldAshkhasHoghoghiId], [fldName], [fldAddress], [fldUserId], [fldDesc], [fldDate], [fldIP],fldPassword)
	SELECT @fldId, @fldAshkhasHoghoghiId, @fldName, @fldAddress, @fldUserId, @fldDesc, getdate(), @fldIP,@fldPassword
	if(@@Error<>0)
        rollback       
	COMMIT
GO
