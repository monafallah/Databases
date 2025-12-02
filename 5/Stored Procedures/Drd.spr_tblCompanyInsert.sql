SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCompanyInsert] 

    @fldTitle nvarchar(200),
    @fldShenaseMeli nvarchar(11),
    @fldKarbarId int,
    @fldURL nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldUserNameService nvarchar(50),
    @fldPassService nvarchar(50),
    @fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCompany] 
	INSERT INTO [Drd].[tblCompany] ([fldId], [fldTitle], [fldShenaseMeli], [fldKarbarId], [fldURL], [fldUserId], [fldDesc], [fldDate],[fldUserNameService],[fldPassService],fldOrganId)
	SELECT @fldId, @fldTitle, @fldShenaseMeli, @fldKarbarId, @fldURL, @fldUserId, @fldDesc, GETDATE(),@fldUserNameService,@fldPassService,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
