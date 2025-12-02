SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosUserDelete] 
	@fldID int,
	@fldUserID int,
	@fieldname nvarchar(50)
AS 
	    BEGIN TRAN
	    if (@fieldname=N'fldPosIpId')
			DELETE
			FROM   [Drd].[tblPcPosUser]
			WHERE  fldPosIpId = @fldId
	 
	 if (@fieldname=N'fldId')
	 BEGIN
		UPDATE  [Drd].[tblPcPosUser]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		DELETE
		FROM   [Drd].[tblPcPosUser]
		WHERE  fldId = @fldId
	end

	COMMIT
GO
