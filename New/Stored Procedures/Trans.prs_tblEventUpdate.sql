SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventUpdate] 
    @fldId int,
    @fldTransactionTypeId int,

    @fldFlag bit,
	@fldDesc nvarchar(100)
AS 
	BEGIN TRAN
	set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [Trans].[tblEvent]
	SET    [fldTransactionTypeId] = @fldTransactionTypeId,  [fldFlag] = @fldFlag,fldDesc=@fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
