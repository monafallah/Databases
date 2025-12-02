SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterMinutInsert] 
    @fldId int output,
    @fldShomareHesabCodeDaramadId int,
    @fldTitle nvarchar(400),
    @fldDescMinut nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX) ,
	@fldSodoorBadAzVarizNaghdi bit,
	@fldSodoorBadAzTaghsit bit,
	@fldTanzimkonande bit
AS 
	
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDescMinut=com.fn_TextNormalize(@fldDescMinut)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblLetterMinut] 
	INSERT INTO [Drd].[tblLetterMinut] ([fldId], [fldShomareHesabCodeDaramadId], [fldTitle], [fldDescMinut], [fldUserId], [fldDate], [fldDesc],fldSodoorBadAzVarizNaghdi,fldSodoorBadAzTaghsit,fldTanzimkonande)
	SELECT @fldId, @fldShomareHesabCodeDaramadId, @fldTitle, @fldDescMinut, @fldUserId, getdate(), @fldDesc,@fldSodoorBadAzVarizNaghdi,@fldSodoorBadAzTaghsit,@fldTanzimkonande
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
