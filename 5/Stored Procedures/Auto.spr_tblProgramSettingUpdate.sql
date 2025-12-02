SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Auto].[spr_tblProgramSettingUpdate] 
    @fldID int,
    @fldEmailAddress nvarchar(100),
    @fldEmailPassword nvarchar(100),
    @fldRecieveServer nvarchar(100),
    @fldSendServer nvarchar(100),
    @fldSendPort int,
    @fldSSL bit,
    @fldDelFax bit,
    @fldIsSigner bit,
    @fldFaxPath nvarchar(100),
    @fldOrganID int,  
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15),
   
    @fldRecievePort int
    
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	
	SET @fldEmailAddress=com.fn_TextNormalize(@fldEmailAddress)
	SET @fldEmailPassword=com.fn_TextNormalize(@fldEmailPassword)
	SET @fldRecieveServer=com.fn_TextNormalize(@fldRecieveServer)
	SET @fldSendServer=com.fn_TextNormalize(@fldSendServer)
	SET @fldFaxPath=com.fn_TextNormalize(@fldFaxPath)
	
		UPDATE [Auto].[tblProgramSetting]
		SET    [fldEmailAddress] = @fldEmailAddress, [fldEmailPassword] = @fldEmailPassword, [fldRecieveServer] = @fldRecieveServer, [fldSendServer] = @fldSendServer, [fldSendPort] = @fldSendPort, [fldSSL] = @fldSSL, [fldDelFax] = @fldDelFax, [fldIsSigner] = @fldIsSigner, [fldFaxPath] = @fldFaxPath, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP,[fldRecievePort]=@fldRecievePort
		WHERE  [fldID] = @fldID
		IF(@@ERROR<>0)
		BEGIN 
			ROLLBACK 
			SET @flag=1
		END
		
	COMMIT TRAN

GO
