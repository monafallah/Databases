SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosParametrUpdate] 
    @fldId int,
    @fldFaName nvarchar(50),
    @fldEnName nvarchar(50),
    @fldPspId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	set @fldFaName=com.fn_TextNormalize(@fldFaName)
	set @fldEnName=com.fn_TextNormalize(@fldEnName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPcPosParametr]
	SET    [fldFaName] = @fldFaName, [fldEnName] = @fldEnName,[fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldPspId=@fldPspId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
