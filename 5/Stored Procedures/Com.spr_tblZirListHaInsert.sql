SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblZirListHaInsert] 
  
    @fldReportId int,
    @fldMasuolin_DetailId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblZirListHa] 
	INSERT INTO [Com].[tblZirListHa] ([fldId], [fldReportId], [fldMasuolin_DetailId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldReportId, @fldMasuolin_DetailId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
