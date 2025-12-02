SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterUpdateNumDate] 
    @fldID bigint,    
    @fldLetterNumber nvarchar(50),
  
    @fldUserID int,
	@fldOrganId int
AS 
	BEGIN TRAN
	declare @roz varchar(10)=''
	select @roz=fldtarikh from com.tblDateDim where flddate=cast(getdate() as date )
	UPDATE [Auto].[tblLetter]
	SET    [fldLetterNumber] = @fldLetterNumber,fldUserId=@fldUserID,fldOrganId=@fldOrganId
	,[fldLetterDate] = @roz
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
