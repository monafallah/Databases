SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblSubstituteInsert] 
    
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblSubstitute] 
	INSERT INTO [Auto].[tblSubstitute] ([fldID], [fldSenderComisionID], [fldReceiverComisionID], [fldStartDate], [fldEndDate], [fldStartTime], [fldEndTime], [fldIsSigner], [fldShowReceiverName], [fldDate], [fldUserID], [fldDesc], [fldIP], [fldOrganId])
	SELECT @fldID, @fldSenderComisionID, @fldReceiverComisionID, @fldStartDate, @fldEndDate, @fldStartTime, @fldEndTime, @fldIsSigner, @fldShowReceiverName, GETDATE(), @fldUserID, @fldDesc, @fldIP, @fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
