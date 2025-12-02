SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRequestTaghsit_TakhfifUpdate] 
    @fldId int,
    @fldElamAvarezId int,
    @fldRequestType tinyint,
    @fldEmployeeId int,
    @fldAddress nvarchar(MAX),
    @fldEmail nvarchar(150),
    @fldCodePosti nvarchar(10),
    @fldMobile nvarchar(11),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	set  @fldAddress=com.fn_TextNormalize(@fldAddress)
	set  @fldEmail=com.fn_TextNormalize(@fldEmail)
	set  @fldCodePosti=com.fn_TextNormalize(@fldCodePosti)
	set  @fldMobile=com.fn_TextNormalize(@fldMobile)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblRequestTaghsit_Takhfif]
	SET    [fldId] = @fldId, [fldElamAvarezId] = @fldElamAvarezId, [fldRequestType] = @fldRequestType, [fldEmployeeId] = @fldEmployeeId, [fldAddress] = @fldAddress, [fldEmail] = @fldEmail, [fldCodePosti] = @fldCodePosti, [fldMobile] = @fldMobile, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
