SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTavighKosuratInsert] 

    @fldKosuratId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblTavighKosurat] 
	INSERT INTO [Pay].[tblTavighKosurat] ([fldId], [fldKosuratId], [fldYear], [fldMonth], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldKosuratId, @fldYear, @fldMonth, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
