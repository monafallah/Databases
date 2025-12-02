SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblGozareshatFileUpdate] 
    @fldId int,
    @fldGozareshatId int,
    @fldOrganId int,
    @fldReportFileId int,
    @file VARBINARY(max),
    @Passvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	IF(@file IS NULL)
	UPDATE [Drd].[tblGozareshatFile]
	SET    [fldId] = @fldId, [fldGozareshatId] = @fldGozareshatId, [fldOrganId] = @fldOrganId, [fldReportFileId] = @fldReportFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	
	ELSE 
	BEGIN
		UPDATE [Drd].[tblGozareshatFile]
		SET    [fldId] = @fldId, [fldGozareshatId] = @fldGozareshatId, [fldOrganId] = @fldOrganId, [fldReportFileId] = @fldReportFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
		WHERE  [fldId] = @fldId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
		IF(@flag=0)
		BEGIN
		UPDATE Com.tblFile
		SET fldImage=@file,fldPasvand=@Passvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
		where fldId=@fldReportFileId
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
		end
	END
	
	
	
	
	COMMIT TRAN
GO
