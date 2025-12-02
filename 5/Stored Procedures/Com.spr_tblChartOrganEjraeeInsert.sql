SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganEjraeeInsert] 

    @fldTitle nvarchar(200),
    @fldPId int,
    @fldOrganId int,
    @fldNoeVahed tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle) 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblChartOrganEjraee] 
	INSERT INTO [Com].[tblChartOrganEjraee] ([fldId], [fldTitle], [fldPId], [fldOrganId], [fldNoeVahed], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldPId, @fldOrganId, @fldNoeVahed, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
