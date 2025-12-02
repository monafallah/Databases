SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMandehPasAndazInsert] 
 
    @fldPersonalId int,
    @FldMablagh int,
    @fldTarikhSabt nvarchar(10),
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMandehPasAndaz] 
	INSERT INTO [Pay].[tblMandehPasAndaz] ([fldId], [fldPersonalId], [FldMablagh], [fldTarikhSabt], [fldUserID], [fldDesc], [fldDate])
	SELECT @fldId, @fldPersonalId, @FldMablagh, @fldTarikhSabt, @fldUserID, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
