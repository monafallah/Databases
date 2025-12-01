SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_tblUserUpdate] 
    @fldId int,
    @fldUserName nvarchar(100),
    @fldActive_Deactive bit,
	@fldShakhsId int,
    @fldUserId int,
	@fldInputID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblUser]
	SET    [fldId] = @fldId, [fldUserName] = @fldUserName,[fldActive_Deactive] = @fldActive_Deactive, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldShakhsId=@fldShakhsId
	,fldInputID=@fldInputID
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
