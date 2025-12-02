SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaInsert] 
    
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblKala] 
	INSERT INTO [com].[tblKala] ([fldId], [fldName], [fldKalaType], [fldKalaCode], [fldStatus], [fldSell], [fldArzeshAfzodeh], [fldIranCode], [fldMoshakhaseType], [fldMoshakhase], [fldVahedAsli], [fldVahedFaree], [fldNesbatType], [fldVahedMoadel], [fldDesc], [fldDate], [fldIP], [fldUserId],fldOrganId )
	SELECT @fldId, @fldName, @fldKalaType, @fldKalaCode, @fldStatus, @fldSell, @fldArzeshAfzodeh, @fldIranCode, @fldMoshakhaseType, @fldMoshakhase, @fldVahedAsli, @fldVahedFaree, @fldNesbatType, @fldVahedMoadel, @fldDesc, GETDATE(), @fldIP, @fldUserId,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
