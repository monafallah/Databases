SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblInputInfoInsert] 
   
    @fldDateTime datetime,
    @fldIP nvarchar(16),
    @fldMACAddress nvarchar(50),
    @fldLoginType bit,
    @fldUserID int,

    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 

		
			select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblInputInfo] 
			INSERT INTO [com].[tblInputInfo] ([fldId], [fldDateTime], [fldIP], [fldMACAddress], [fldLoginType], [fldUserID],  [fldDesc], [fldDate])
			SELECT @fldId, @fldDateTime, @fldIP, @fldMACAddress, @fldLoginType, @fldUserID,  @fldDesc, GETDATE()
	
	
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
