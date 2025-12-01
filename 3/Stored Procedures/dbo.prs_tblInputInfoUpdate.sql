SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblInputInfoUpdate] 
    @fldId int,
    @fldDateTime datetime,
    @fldIP varchar(50),
    @fldMACAddress varchar(50),
    @fldLoginType tinyint,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldBrowserType varchar(100) = NULL,
    @fldKey varchar(100) = NULL,
    @fldAppType tinyint,
	@fldUserSecodId int
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblInputInfo]
	SET    [fldDateTime] = @fldDateTime, [fldIP] = @fldIP, [fldMACAddress] = @fldMACAddress, [fldLoginType] = @fldLoginType, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldBrowserType] = @fldBrowserType, [fldKey] = @fldKey, [fldAppType] = @fldAppType
	,@fldUserSecodId=@fldUserSecodId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
