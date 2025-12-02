SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterMinutUpdate] 
    @fldId int,
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
	UPDATE [Drd].[tblLetterMinut]
	SET    [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldTitle] = @fldTitle, [fldDescMinut] = @fldDescMinut, [fldUserId] = @fldUserId, [fldDate] = getdate(), [fldDesc] = @fldDesc ,fldSodoorBadAzVarizNaghdi=@fldSodoorBadAzVarizNaghdi,fldSodoorBadAzTaghsit=@fldSodoorBadAzTaghsit,fldTanzimkonande=@fldTanzimkonande
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
