SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblHistoryTahsilatInsert] 
    @fldEmployeeId int,
    @fldMadrakId int,
    @fldReshteId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblHistoryTahsilat] 
	INSERT INTO [Com].[tblHistoryTahsilat] ([fldId], [fldEmployeeId], [fldMadrakId], [fldReshteId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldEmployeeId, @fldMadrakId, @fldReshteId, @fldTarikh, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		select top 1 @fldMadrakId=fldMadrakId,@fldReshteId=fldReshteId from [Com].[tblHistoryTahsilat]
		where fldEmployeeId=@fldEmployeeId
		order by fldTarikh desc
		update com.tblEmployee_Detail set fldMadrakId=@fldMadrakId,fldReshteId=@fldReshteId
		where fldEmployeeId=@fldEmployeeId
	end
	COMMIT
GO
