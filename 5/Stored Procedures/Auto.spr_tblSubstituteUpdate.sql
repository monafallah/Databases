SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblSubstituteUpdate] 
    @fldID int,
    @fldSenderComisionID int,
    @fldReceiverComisionID int,
    @fldStartDate CHAR(10),
    @fldEndDate CHAR(10),
    @fldStartTime time,
    @fldEndTime time,
    @fldIsSigner bit,
    @fldShowReceiverName bit,
    
    @fldUserID int,
    @fldDesc nvarchar(50),
    @fldIP varchar(15),
    @fldOrganId int
AS 
	BEGIN TRAN
	UPDATE [Auto].[tblSubstitute]
	SET    [fldID] = @fldID, [fldSenderComisionID] = @fldSenderComisionID, [fldReceiverComisionID] = @fldReceiverComisionID, [fldStartDate] = @fldStartDate, [fldEndDate] = @fldEndDate, [fldStartTime] = @fldStartTime, [fldEndTime] = @fldEndTime, [fldIsSigner] = @fldIsSigner, [fldShowReceiverName] = @fldShowReceiverName, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldOrganId] = @fldOrganId
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
