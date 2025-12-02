SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldKalaType tinyint,
    @fldKalaCode char(20),
    @fldStatus tinyint,
    @fldSell bit,
    @fldArzeshAfzodeh bit,
    @fldIranCode varchar(50),
    @fldMoshakhaseType tinyint,
    @fldMoshakhase varchar(50),
    @fldVahedAsli int,
    @fldVahedFaree int,
    @fldNesbatType tinyint,
    @fldVahedMoadel int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrganId int
AS 
	BEGIN TRAN
	UPDATE [com].[tblKala]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldKalaType] = @fldKalaType, [fldKalaCode] = @fldKalaCode, [fldStatus] = @fldStatus, [fldSell] = @fldSell, [fldArzeshAfzodeh] = @fldArzeshAfzodeh, [fldIranCode] = @fldIranCode, [fldMoshakhaseType] = @fldMoshakhaseType, [fldMoshakhase] = @fldMoshakhase, [fldVahedAsli] = @fldVahedAsli, [fldVahedFaree] = @fldVahedFaree, [fldNesbatType] = @fldNesbatType, [fldVahedMoadel] = @fldVahedMoadel, [fldDesc] = @fldDesc, [fldDate] =GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
