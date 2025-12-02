SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblShomareInsert] 
  
    @fldRadifId int,
    @fldShomare nvarchar(30),
    @fldTedadTabaghat tinyint,
	@fldOrganId int,
    @fldUserId int,
    @fldIp nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblShomare] 

	INSERT INTO [Dead].[tblShomare] ([fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], [fldUserId], [fldIp], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldRadifId, @fldShomare, @fldTedadTabaghat, @fldUserId, @fldIp, @fldDesc, getdate(),@fldOrganId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
