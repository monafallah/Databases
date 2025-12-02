SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 Create PROC [Pay].[spr_tblMonasebatMablaghCopy] 
	@fldHeaderID int ,
    @fldActiveDate int,
    @fldIP varchar(15),
    @fldUserId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMonasebatHeader] 
	INSERT INTO [Pay].[tblMonasebatHeader] ([fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate])
	SELECT @fldId, @fldActiveDate, null, 1, @fldIP, @fldUserId, getdate()
	
	if (@@ERROR<>0)
		ROLLBACK
		else
		begin
			declare @fldDetailId int
			select @fldDetailId=isnull(max(fldId),0)  FROM   [Pay].[tblMonasebatMablagh] 
			INSERT INTO [Pay].[tblMonasebatMablagh] ([fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], [fldIP], [fldUserId], [fldDate])
			SELECT @fldDetailId+ROW_NUMBER() over(order by fldId), @fldID, fldMonasebatId, fldMablagh, fldTypeNesbatId, @fldIP, @fldUserId, getdate()
			from [Pay].[tblMonasebatMablagh] 
			where fldHeaderId=@fldHeaderID

		end
	COMMIT
GO
