SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserUpdate] 
    @fldId int,
    @fldEmployId int,
    @fldUserName nvarchar(100),
    @fldActive_Deactive bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	set @fldDesc=replace(@fldDesc,N'_رمز اشتباه','')
	UPDATE [Com].[tblUser]
	SET    [fldId] = @fldId, [fldEmployId] = @fldEmployId, [fldUserName] = @fldUserName,  [fldActive_Deactive] = @fldActive_Deactive,  [fldUserId] = @fldUserId, fldDesc=@fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
