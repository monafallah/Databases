SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosInfoInsert] 
  
    @fldPspId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosInfo] 
	INSERT INTO [Drd].[tblPcPosInfo] ([fldId],[fldOrganId], [fldUserId], [fldDesc], [fldDate],fldPspId)
	SELECT @fldId, @fldOrganId, @fldUserId, @fldDesc, getdate(),@fldPspId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
