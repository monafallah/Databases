SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblInputInfoUpdate] 
    @fldId int,
    @fldDateTime datetime,
    @fldIP nvarchar(16),
    @fldMACAddress nvarchar(50),
    @fldLoginType bit,
    @fldUserID int,
   
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [com].[tblInputInfo]
	SET    [fldId] = @fldId, [fldDateTime] = @fldDateTime, [fldIP] = @fldIP, [fldMACAddress] = @fldMACAddress, [fldLoginType] = @fldLoginType, [fldUserID] = @fldUserID,  [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
