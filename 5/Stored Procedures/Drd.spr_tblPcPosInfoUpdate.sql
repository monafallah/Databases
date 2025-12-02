SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosInfoUpdate] 
    @fldId int,
    @fldPspId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPcPosInfo]
	SET    [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldPspId=@fldPspId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
