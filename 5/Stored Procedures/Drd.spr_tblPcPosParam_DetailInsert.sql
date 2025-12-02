SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPcPosParam_DetailInsert] 
    
    @fldPcPosParamId int,
    @fldPcPosInfoId int,
    @fldValue nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	
	BEGIN TRAN
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosParam_Detail] 
	INSERT INTO [Drd].[tblPcPosParam_Detail] ([fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPcPosParamId, @fldPcPosInfoId, @fldValue, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
