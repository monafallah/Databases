SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosuratBankUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldShobeId int,
    @fldMablagh int,
    @fldCount smallint,
    @fldTarikhPardakht nvarchar(10),
    @fldShomareHesab nvarchar(50),
    @fldStatus bit,
    @fldDeactiveDate int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
    ,@fldMandeAzGhabl int,
    @fldMandeDarFish bit,
	@fldShomareSheba nvarchar(27) 
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKosuratBank]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldShobeId] = @fldShobeId, [fldMablagh] = @fldMablagh, [fldCount] = @fldCount, [fldTarikhPardakht] = @fldTarikhPardakht, [fldShomareHesab] = @fldShomareHesab, [fldStatus] = @fldStatus, [fldDeactiveDate] = @fldDeactiveDate, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldMandeAzGhabl=@fldMandeAzGhabl,fldMandeDarFish=@fldMandeDarFish,fldShomareSheba=@fldShomareSheba
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
