SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionGroupUpdate] 
    @fldId int,
    @fldName nvarchar(200)
AS 
	BEGIN TRAN
	SET @fldName=dbo.fn_TextNormalize(@fldName)
	UPDATE [Trans].[tblTransactionGroup]
	SET    [fldName] = @fldName
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
