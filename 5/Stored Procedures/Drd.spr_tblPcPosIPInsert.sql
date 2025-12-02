SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosIPInsert] 
    @fldId int output,
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
	select @fldId =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosIP] 
	INSERT INTO [Drd].[tblPcPosIP] ([fldId], [fldPcPosInfoId], [fldSerial], [fldUserId], [fldDesc], [fldDate],fldIp)
	SELECT @fldId, @fldPcPosInfoId, @fldSerial, @fldUserId, @fldDesc, getdate(),@fldIp
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
