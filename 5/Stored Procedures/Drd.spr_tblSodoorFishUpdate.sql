SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSodoorFishUpdate] 
    @fldId int,
    @fldElamAvarezId int,
    @fldShomareHesabId int,

    @fldMablaghAvarezGerdShode BIGINT,
    @fldShorooShenaseGhabz tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldJamKol BIGINT

AS 
	BEGIN TRAN

	set  @fldDesc=com.fn_TextNormalize(@fldDesc)

	UPDATE [Drd].[tblSodoorFish]
	SET    [fldId] = @fldId, [fldElamAvarezId] = @fldElamAvarezId, [fldShomareHesabId] = @fldShomareHesabId,[fldMablaghAvarezGerdShode] = @fldMablaghAvarezGerdShode, [fldShorooShenaseGhabz] = @fldShorooShenaseGhabz,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldJamKol=@fldJamKol 
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
