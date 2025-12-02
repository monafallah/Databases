SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMamuriyatUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatePardakht tinyint,
    @fldBaBeytute tinyint,
    @fldBeduneBeytute tinyint,
    @fldBa10 tinyint,
    @fldBa20 tinyint,
    @fldBa30 tinyint,
    @fldBe10 tinyint,
    @fldBe20 tinyint,
    @fldBe30 tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMamuriyat]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldNobatePardakht] = @fldNobatePardakht, [fldBaBeytute] = @fldBaBeytute, [fldBeduneBeytute] = @fldBeduneBeytute, [fldBa10] = @fldBa10, [fldBa20] = @fldBa20, [fldBa30] = @fldBa30, [fldBe10] = @fldBe10, [fldBe20] = @fldBe20, [fldBe30] = @fldBe30, [fldUserId] = @fldUserId, [fldDate] =GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
