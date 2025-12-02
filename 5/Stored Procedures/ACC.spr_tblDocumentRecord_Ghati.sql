SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_Ghati] 
    @fldId int,
    @fldUserId int
AS 
	BEGIN TRAN
	declare @logId int
	update [ACC].[tblDocumentRecord_Header1]
	set fldAccept=1 
	where fldid=@fldId
	if (@@ERROR<>0)
		rollback
	else
	begin
		select @logId =ISNULL(max(fldId),0)+1 from [ACC].tblDocument_HeaderLog
		insert into Acc.tblDocument_HeaderLog(fldid,fldHeaderId,fldUserId,fldDate)
		select+@logId,@fldId,@fldUserId,getdate() 
		if (@@ERROR<>0)
			rollback	
	end
	COMMIT TRAN

GO
