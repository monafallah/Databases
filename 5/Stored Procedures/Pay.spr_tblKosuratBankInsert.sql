SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosuratBankInsert] 
 
    @fldPersonalId int,
    @fldShobeId int,
    @fldMablagh int,
    @fldCount smallint,
    @fldTarikhPardakht nvarchar(10),
    @fldShomareHesab nvarchar(50),
    @fldStatus bit,
    @fldDeactiveDate int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldMandeAzGhabl	int	,
	@fldMandeDarFish	bit	,
	@fldShomareSheba  nvarchar(27)
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKosuratBank] 
	INSERT INTO [Pay].[tblKosuratBank] ([fldId], [fldPersonalId], [fldShobeId], [fldMablagh], [fldCount], [fldTarikhPardakht], [fldShomareHesab], [fldStatus], [fldDeactiveDate], [fldUserID], [fldDesc], [fldDate],fldMandeAzGhabl,fldMandeDarFish,fldShomareSheba )
	SELECT @fldId, @fldPersonalId, @fldShobeId, @fldMablagh, @fldCount, @fldTarikhPardakht, @fldShomareHesab, @fldStatus, @fldDeactiveDate, @fldUserID, @fldDesc, GETDATE(),@fldMandeAzGhabl,@fldMandeDarFish,@fldShomareSheba
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
