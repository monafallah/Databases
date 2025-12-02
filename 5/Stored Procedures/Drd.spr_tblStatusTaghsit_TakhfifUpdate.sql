SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblStatusTaghsit_TakhfifUpdate] 
    @fldId int,
    @fldRequestId int,
    @fldTypeMojavez tinyint,
    @fldTypeRequest tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
 
AS 
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblStatusTaghsit_Takhfif]
	SET    [fldId] = @fldId, [fldRequestId] = @fldRequestId, [fldTypeMojavez] = @fldTypeMojavez, [fldTypeRequest] = @fldTypeRequest, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getDate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
