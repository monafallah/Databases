SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblInputInfoInsert] 
   @fldID INT out,
    @fldIP varchar(16),
    @fldMACAddress varchar(50),
    @fldLoginType tinyint,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldBrowserType VARCHAR(100),
    @fldKey VARCHAR(100),
    @fldAppType TINYINT,
	@fldUserSecondId int

AS 
	
	
	BEGIN TRAN
	
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblInputInfo] 
	INSERT INTO [dbo].[tblInputInfo] ([fldId], [fldDateTime], [fldIP], [fldMACAddress], [fldLoginType], [fldUserID], [fldDesc],[fldBrowserType],[fldkey],[fldAppType],fldUserSecondId)
	SELECT @fldId,getdate(), @fldIP, @fldMACAddress, @fldLoginType, @fldUserID, @fldDesc, @fldBrowserType,@fldKey,@fldAppType,@fldUserSecondId
	IF(@@ERROR<>0)
	ROLLBACK
	commit
GO
