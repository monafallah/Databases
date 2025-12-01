SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationMacAddressDelete] 
@fldID int,
@fldinputID int
AS 
	
	BEGIN TRAN
	
	DELETE
	FROM   [dbo].[tblLimitationMacAddress]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
