SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationMacAddressUpdate] 
    @fldId int,
    @fldUserLimId int,
    @fldMacValid varchar(100),
    @fldDesc nvarchar(100),
	@fldInputId INT
AS 

	BEGIN TRAN

	UPDATE [dbo].[tblLimitationMacAddress]
	SET    [fldUserLimId] = @fldUserLimId, [fldMacValid] = @fldMacValid, [fldDesc] = @fldDesc
	WHERE  fldId=@fldId
	if(@@Error<>0)
       begin 
		rollback  
		end
	
	COMMIT
GO
