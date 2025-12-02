SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheck_SmsInsert] 
   
    @fldCheckId int,
    @fldStatus tinyint,
    @fldUserId int,
   
    @fldIP nvarchar(15)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Drd].[tblCheck_Sms] 
	INSERT INTO [Drd].[tblCheck_Sms] ([fldId], [fldCheckId], [fldStatus], [fldUserId], [fldIP], [fldDate])
	SELECT @fldId, @fldCheckId, @fldStatus, @fldUserId, @fldIP, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
