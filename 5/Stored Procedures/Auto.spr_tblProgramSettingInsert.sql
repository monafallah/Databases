SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblProgramSettingInsert] 
    
    
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
	
	BEGIN tran
	
	SET @fldEmailAddress=com.fn_TextNormalize(@fldEmailAddress)
	SET @fldEmailPassword=com.fn_TextNormalize(@fldEmailPassword)
	SET @fldRecieveServer=com.fn_TextNormalize(@fldRecieveServer)
	SET @fldSendServer=com.fn_TextNormalize(@fldSendServer)
	SET @fldFaxPath=com.fn_TextNormalize(@fldFaxPath)
	declare @fldID INT,@flag BIT=0,@fldFileId INT
	
	select @fldID =ISNULL(max(fldId),0)+1 FROM Auto.tblProgramSetting
	INSERT INTO Auto.tblProgramSetting
	        ( fldID ,fldEmailAddress ,fldEmailPassword ,fldRecieveServer ,
	          fldSendServer ,fldSendPort ,fldSSL ,fldDelFax ,fldIsSigner , fldFaxPath ,fldOrganID ,
	          fldDate ,fldUserID ,fldDesc ,fldIP,fldRecievePort)
	          
	   SELECT  @fldID ,@fldEmailAddress ,@fldEmailPassword ,@fldRecieveServer ,
	          @fldSendServer ,@fldSendPort ,@fldSSL ,@fldDelFax ,@fldIsSigner , @fldFaxPath ,@fldOrganID ,
	         GETDATE(),@fldUserID ,@fldDesc ,@fldIP,@fldRecievePort      
	          
	    IF(@@ERROR<>0)
	 
	COMMIT 
	
	
	   
	          
	          
	          
	          
	         
	          
	          
	          
	          
	          
	       
GO
