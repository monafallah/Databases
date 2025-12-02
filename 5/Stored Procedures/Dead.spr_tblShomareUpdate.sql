SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblShomareUpdate] 
    @fldId int,
    @fldRadifId int,
    @fldShomare nvarchar(30),
    @fldTedadTabaghat tinyint,
	@fldOrganId int,
    @fldUserId int,
    @fldIp nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN

	UPDATE [Dead].[tblShomare]
	SET    [fldRadifId] = @fldRadifId, [fldShomare] = @fldShomare, [fldTedadTabaghat] = @fldTedadTabaghat, [fldUserId] = @fldUserId, [fldIp] = @fldIp, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldOrganId=@fldOrganId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
