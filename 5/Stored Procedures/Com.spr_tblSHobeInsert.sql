SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblSHobeInsert] 

    @fldBankId int,
    @fldName NVARCHAR(50),
    @fldCodeSHobe int,
    @fldAddress nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int,@flag BIT=0
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblSHobe] 
	INSERT INTO [Com].[tblSHobe] ([fldId], [fldBankId], [fldName], [fldCodeSHobe], [fldAddress],  [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldBankId, @fldName, @fldCodeSHobe, @fldAddress, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	
	COMMIT
GO
