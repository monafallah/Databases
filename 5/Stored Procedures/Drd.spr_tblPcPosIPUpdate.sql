SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosIPUpdate] 
    @fldId int,
    @fldPcPosInfoId int,
    @fldSerial nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldIp nvarchar(15)
 
AS 
	BEGIN TRAN
	set @fldSerial=com.fn_TextNormalize(@fldSerial)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldIp=com.fn_TextNormalize(@fldIp)
	UPDATE [Drd].[tblPcPosIP]
	SET    [fldPcPosInfoId] = @fldPcPosInfoId, [fldSerial] = @fldSerial, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldIp=@fldIp
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
