SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblElamAvarezUpdate] 
    @fldId int,
    @fldAshakhasID int,
    @fldType bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId INT,
	@fldDaramadGroupId INT,
	@fldCodeSystemMabda NVARCHAR(50)
  
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblElamAvarez]
	SET    [fldAshakhasID] = @fldAshakhasID, [fldType] = @fldType, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldOrganId=@fldOrganId,fldDaramadGroupId=@fldDaramadGroupId
	,fldCodeSystemMabda=@fldCodeSystemMabda
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
