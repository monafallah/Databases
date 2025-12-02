SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_DetailsDelete] 
	@fieldname nvarchar(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	if(@fieldname=N'fldId')
	begin
		update [ACC].[tblDocumentRecord_Details]
		set fldUserId=@fldUserId,fldDate=getdate() where fldId=@fldID
		DELETE
		FROM   [ACC].[tblArtiklMap]
		WHERE  fldDocumentRecord_DetailsId = @fldId
		DELETE
		FROM   [ACC].[tblDocumentRecord_Details]
		WHERE  fldId = @fldId
	end
	if(@fieldname=N'fldDocument_HedearId')
	begin
		update [ACC].[tblDocumentRecord_Details]
		set fldUserId=@fldUserId,fldDate=getdate() where fldDocument_HedearId=@fldID
		DELETE a 
								FROM   [ACC].[tblDocumentRecord_Details] as d 
								inner join [ACC].[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
								WHERE  fldDocument_HedearId = @fldId
								if (@@Error<>0)
								rollback
								else
		DELETE
		FROM   [ACC].[tblDocumentRecord_Details]
		WHERE  fldDocument_HedearId = @fldId
		if (@@Error<>0)
								rollback
	end
	COMMIT
GO
