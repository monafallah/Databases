SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblHistoryTahsilatUpdate] 
    @fldId int,
    @fldEmployeeId int,
    @fldMadrakId int,
    @fldReshteId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblHistoryTahsilat]
	SET    [fldEmployeeId] = @fldEmployeeId, [fldMadrakId] = @fldMadrakId, [fldReshteId] = @fldReshteId, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =  GETDATE()
	WHERE  [fldId] = @fldId
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
	COMMIT TRAN
GO
