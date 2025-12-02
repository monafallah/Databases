SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblSHobeUpdate] 
    @fldId int,
    @fldBankId int,
    @fldName NVARCHAR(50),
    @fldCodeSHobe int,
    @fldAddress nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblSHobe]
	SET    [fldId] = @fldId, [fldBankId] = @fldBankId, [fldName] = @fldName, [fldCodeSHobe] = @fldCodeSHobe, [fldAddress] = @fldAddress,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	
	COMMIT TRAN
GO
