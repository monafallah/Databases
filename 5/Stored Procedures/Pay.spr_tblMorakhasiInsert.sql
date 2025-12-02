SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMorakhasiInsert] 

    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatePardakht tinyint,
    @fldSalAkharinHokm smallint,
    @fldTedad int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMorakhasi] 
	INSERT INTO [Pay].[tblMorakhasi] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakht], [fldSalAkharinHokm], [fldTedad], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldNobatePardakht, @fldSalAkharinHokm, @fldTedad, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
