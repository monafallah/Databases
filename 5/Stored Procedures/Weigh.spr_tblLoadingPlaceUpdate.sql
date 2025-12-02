SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblLoadingPlaceUpdate] 
    @fldId int,
    @fldName nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(100),

    @fldIP varchar(50)
AS 

	BEGIN TRAN
	set @fldDesc =com.fn_TextNormalize(@fldDesc)
	set @fldName =com.fn_TextNormalize(@fldName)
	UPDATE [Weigh].[tblLoadingPlace]
	SET    [fldName] = @fldName, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
