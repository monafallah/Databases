SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMamuriyatInsert] 
  
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMamuriyat] 
	INSERT INTO [Pay].[tblMamuriyat] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakht], [fldBaBeytute], [fldBeduneBeytute], [fldBa10], [fldBa20], [fldBa30], [fldBe10], [fldBe20], [fldBe30], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldNobatePardakht, @fldBaBeytute, @fldBeduneBeytute, @fldBa10, @fldBa20, @fldBa30, @fldBe10, @fldBe20, @fldBe30, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
