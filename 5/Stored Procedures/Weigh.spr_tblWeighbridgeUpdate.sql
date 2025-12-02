SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblWeighbridgeUpdate] 
    @fldId int,
    @fldAshkhasHoghoghiId int,
    @fldName nvarchar(150),
    @fldAddress nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
		set @fldName=com.fn_TextNormalize(@fldName)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)
	UPDATE [Weigh].[tblWeighbridge]
	SET    [fldAshkhasHoghoghiId] = @fldAshkhasHoghoghiId, [fldName] = @fldName, [fldAddress] = @fldAddress, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP

	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
