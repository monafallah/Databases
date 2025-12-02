SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblCommisionInsert] 
    
    @fldAshkhasID int,
    @fldOrganizPostEjraeeID int,
    @fldStartDate CHAR(10),
    @fldEndDate CHAR(10),
    @fldOrganicNumber nvarchar(100),
	@fldSign bit,
    @fldOrganID int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	
	BEGIN TRAN
	SET @fldOrganicNumber=com.fn_TextNormalize(@fldOrganicNumber)
	declare @fldID int 
	DECLARE @fldBox int
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblCommision] 
	INSERT INTO [Auto].[tblCommision] ([fldID], [fldAshkhasID], [fldOrganizPostEjraeeID], [fldStartDate], [fldEndDate], [fldOrganicNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP],fldSign)
	SELECT @fldID, @fldAshkhasID, @fldOrganizPostEjraeeID, @fldStartDate, @fldEndDate, @fldOrganicNumber, @fldOrganID, GETDATE(), @fldUserID, @fldDesc, @fldIP,@fldSign
	if (@@ERROR<>0)
		ROLLBACK

   else 
   begin
	   SELECT @fldbox=ISNULL(MAX(fldId),0) FROM [Auto].[tblBox]
	   INSERT INTO [Auto].[tblBox]
		 (fldId,fldName , fldComisionID , fldBoxTypeID , fldPID ,fldOrganID , fldDate , fldUserID , fldDesc ,fldIP)
		SELECT @fldbox+ROW_NUMBER() OVER (ORDER BY fldID),fldtype,@fldId,fldId,NULL, @fldOrganID,GETDATE(),@fldUserID,@fldDesc,@fldIp FROM Auto.tblBoxType
	   where fldType<>N'سایر'
 		if (@@ERROR<>0)
			ROLLBACK
	end
	COMMIT
GO
