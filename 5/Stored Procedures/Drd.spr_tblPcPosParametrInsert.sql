SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPcPosParametrInsert] 
  
    @fldFaName nvarchar(50),
    @fldEnName nvarchar(50),
    @fldPspId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	
	BEGIN TRAN
	set @fldFaName=com.fn_TextNormalize(@fldFaName)
	set @fldEnName=com.fn_TextNormalize(@fldEnName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosParametr] 
	INSERT INTO [Drd].[tblPcPosParametr] ([fldId], [fldFaName], [fldEnName], [fldUserId], [fldDesc], [fldDate],fldPspId)
	SELECT @fldId, @fldFaName, @fldEnName,@fldUserId, @fldDesc, getdate(),@fldPspId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
