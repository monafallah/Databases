SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEtelaatEydiInsert] 

    @fldPersonalId int,
    @fldYear smallint,
    @fldDayCount int,
    @fldKosurat int,
    @fldNobatePardakht tinyint,
    @fldUserId int,

    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblEtelaatEydi] 
	INSERT INTO [Pay].[tblEtelaatEydi] ([fldId], [fldPersonalId], [fldYear], [fldDayCount], [fldKosurat], [fldNobatePardakht], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPersonalId, @fldYear, @fldDayCount, @fldKosurat, @fldNobatePardakht, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
