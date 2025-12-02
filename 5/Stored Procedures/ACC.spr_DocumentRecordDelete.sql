SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	CREATE PROC [ACC].[spr_DocumentRecordDelete] 
	@fldID int,
	@fldUserID int
	as 
	update [ACC].[tblDocumentRecord_Header]
	set fldUserId=@fldUserId,fldDate=getdate() where fldId=@fldID
	
	declare @file varchar(max)=''
	select @file=@file+cast(b.fldFileId as varchar(10))+',' from [ACC].[tblDocumentRecorde_File] as b
			where fldDocumentHeaderId = @fldId

	DELETE b
	FROM   [ACC].[tblDocumentBookMark] as b
	inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
	WHERE  f.fldDocumentHeaderId = @fldId
	if (@@Error<>0)
	rollback
	else
	begin
		DELETE
		FROM   [ACC].[tblDocumentRecorde_File]
		WHERE  fldDocumentHeaderId = @fldId
		if (@@Error<>0)
		rollback
		else
		begin
			
			delete com.tblFile
			where fldId in (select Item from com.Split(@file,','))
			if (@@Error<>0)
			rollback
			else
			begin
				DELETE
				FROM   [ACC].[tblDocumentRecord_Details]
				WHERE  fldDocument_HedearId = @fldId
				if (@@Error<>0)
				rollback
				else
				begin
				DELETE
				FROM   [ACC].[tblDocumentRecord_Header1]
				WHERE  fldDocument_HedearId = @fldId
				if (@@Error<>0)
				rollback
				else
				begin
					DELETE
					FROM   [ACC].[tblDocumentRecord_Header]
					WHERE  fldId = @fldId
					if (@@error<>0)
						rollback
				end
				end
			end
		end
	end
GO
