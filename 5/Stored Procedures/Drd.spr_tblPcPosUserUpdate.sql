SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosUserUpdate] 
    @fldId int,
	@fldPosIpId int,
    @fldIdUser int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
 
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPcPosUser]
	SET    [fldPosIpId] =@fldPosIpId, [fldIdUser] = @fldIdUser, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	


	COMMIT TRAN
GO
