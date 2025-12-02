SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCompanyUpdate] 
    @fldId int,
    @fldTitle nvarchar(200),
    @fldShenaseMeli nvarchar(11),
    @fldKarbarId int,
    @fldURL nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldUserNameService nvarchar(50),
    @fldPassService nvarchar(50),
    @fldOrganId INT
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblCompany]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldShenaseMeli] = @fldShenaseMeli, [fldKarbarId] = @fldKarbarId, [fldURL] = @fldURL, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),[fldUserNameService]=@fldUserNameService,[fldPassService]=@fldPassService
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
